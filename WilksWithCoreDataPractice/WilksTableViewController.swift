//
//  WilksTableViewController.swift
//  WilksWithCoreDataPractice
//
//  Created by Mehdi Salemi on 3/6/16.
//  Copyright © 2016 MxMd. All rights reserved.
//

import UIKit
import CoreData

class WilksTableViewController: UITableViewController, addNewWilksProtocol {

    // Mark : Main Variables
    var allWilks = [WilksScore]()
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    // Mark : UI ElEments
    var addButton : UIBarButtonItem!
    
    // Mark : View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewWilks:")
        allWilks = fetchAllWilks()
        print(allWilks.count)
        for wilks in allWilks {
            print(wilks.weight)
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.rightBarButtonItem = addButton
        tableView.reloadData()
    }

    @IBAction func addNewWilks(sender:AnyObject){
        print("Adding new Wilks!")
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("AddNewWilksViewController") as! AddNewWilksViewController
        controller.myProtocol = self
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allWilks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let wilks = allWilks[indexPath.row]
        cell.textLabel!.text = "\(wilks.wilks)"

        return cell
    }
    
    // Mark : Core Data Functions
    func fetchAllWilks() -> [WilksScore] {
        // Create the Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "WilksScore")
        
        // Execute the Fetch Request
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [WilksScore]
        } catch  let error as NSError {
            print("Error in fetchAllActors(): \(error)")
            return [WilksScore]()
        }
    }
    
    // Mark : addNewWilksProtocol Function
    func addNewWilks(weight: Double, squat:Double, bench:Double, deadlift:Double) {
        
        let total : Double = squat+bench+deadlift
        
        let dictionary: [String:AnyObject] = [
            WilksScore.Keys.Wilks : 999.999,
            WilksScore.Keys.Weight : weight,
            WilksScore.Keys.Squat : squat,
            WilksScore.Keys.Bench : bench,
            WilksScore.Keys.Deadlift : deadlift
        ]
        
        let newWilks = WilksScore(dictionary: dictionary, context: self.sharedContext)
        newWilks.wilks = newWilks.calculateWilks(weight, total: total)
        self.allWilks.append(newWilks)
        CoreDataStackManager.sharedInstance().saveContext()
    }

}
