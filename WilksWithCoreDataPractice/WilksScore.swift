//
//  WilksScore.swift
//  WilksWithCoreDataPractice
//
//  Created by Mehdi Salemi on 3/6/16.
//  Copyright © 2016 MxMd. All rights reserved.
//

import Foundation
import CoreData


class WilksScore : NSManagedObject {
    
    struct Keys {
        static let Wilks = "Wilks"
        static let Weight = "Weight"
        static let Squat = "Squat"
        static let Bench = "Bench"
        static let Deadlift = "Deadlift"
    }
    
    @NSManaged var wilks : Double
    @NSManaged var weight : Double
    @NSManaged var squat : Double
    @NSManaged var bench : Double
    @NSManaged var deadlift : Double
    
    // Core-Data Init
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    // Normal Init for WilksScore
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        let entity =  NSEntityDescription.entityForName("WilksScore", inManagedObjectContext: context)!
        
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.wilks = dictionary[Keys.Wilks] as! Double
        self.weight = dictionary[Keys.Weight] as! Double
        self.squat = dictionary[Keys.Squat] as! Double
        self.bench = dictionary[Keys.Bench] as! Double
        self.deadlift = dictionary[Keys.Deadlift] as! Double
    }
    
    func calculateWilks(weight: Double, total: Double) -> Double {
        var wilks : Double = 0.0
        let a = WilksCoefficient.Male.a
        let b = WilksCoefficient.Male.b
        let c = WilksCoefficient.Male.c
        let d = WilksCoefficient.Male.d
        let e = WilksCoefficient.Male.e
        let f = WilksCoefficient.Male.f
        
        wilks += a
        wilks += weight*b
        wilks += weight*weight*c
        wilks += weight*weight*weight*d
        wilks += weight*weight*weight*weight*e
        wilks += weight*weight*weight*weight*weight*f
        
        let coef = 500 / wilks
        
        return coef*total
    }
    
}
