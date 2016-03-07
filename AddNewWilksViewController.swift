//
//  AddNewWilksViewController.swift
//  WilksWithCoreDataPractice
//
//  Created by Mehdi Salemi on 3/6/16.
//  Copyright © 2016 MxMd. All rights reserved.
//

import UIKit

protocol addNewWilksProtocol {
    func addNewWilks(weight: Double, squat:Double, bench:Double, deadlift:Double)
}

class AddNewWilksViewController: UIViewController {

    var myProtocol : addNewWilksProtocol?
    
    // Mark : UIElements
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var squatTextField: UITextField!
    @IBOutlet weak var benchTextField: UITextField!
    @IBOutlet weak var deadliftTextField: UITextField!
    
    @IBAction func add(sender: UIButton) {
        
        let w = Double(weightTextField.text!)
        let s = Double(squatTextField.text!)
        let b = Double(benchTextField.text!)
        let d = Double(deadliftTextField.text!)
        
        myProtocol?.addNewWilks(w!, squat: s!, bench: b!, deadlift: d!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Mark : View Fucntions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
