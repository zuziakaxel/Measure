//
//  Measurement.swift
//  Measure
//
//  Created by Axel Zuziak on 08.11.2015.
//  Copyright © 2015 zuziakaxel. All rights reserved.
//

import Foundation
import CoreMotion

class Measurement {
    var data: MeasurementData = MeasurementData()
}




class MeasurementData {
    var data: [MeasurementEntryX]
    
    subscript(index: Int) -> MeasurementEntryX {
        return data[index]
    }
    
    init() {
        let initialEntry = MeasurementEntryX()
        data = [initialEntry]
    }
    
//    func add(acceleration: CMAcceleration) {
//        var newEntry = MeasurementEntry()
//        newEntry.a = Acceleration(acceleration: acceleration)
//        newEntry.a = G_VALUE * newEntry.a
//        newEntry.v = calculateVelocity(newEntry)
//        newEntry.d = calculateDistance(newEntry)
//        data.append(newEntry)
//        print(newEntry.description)
//    }
    
    
    func addX(acceleration: CMAcceleration) {
        var newEntry = MeasurementEntryX()
        newEntry.a = G_VALUE * acceleration.x
        newEntry.v = calculateVelocityX(newEntry)
        newEntry.d = calculateDistanceX(newEntry)
        data.append(newEntry)
//        print(newEntry.description)
    }
    
//    private func calculateVelocity(newEntry: MeasurementEntry) -> Velocity {
//        let lastMeasurement = data.last!
//        let timeInterval = lastMeasurement.t.timeIntervalSinceDate(newEntry.t)
//        let newAcc = (newEntry.a + lastMeasurement.a)/2.0
//        let velocity = timeInterval * newAcc
//        let newVelocity = lastMeasurement.v + velocity
//        return newVelocity
//    }

    private func calculateVelocityX(newEntry: MeasurementEntryX) -> Double {
        let lastEntry = data.last!
        let timeInterval = newEntry.t.timeIntervalSinceDate(lastEntry.t)
        print(timeInterval)
        return lastEntry.v + (timeInterval * ((newEntry.a + lastEntry.a)/2.0))
    }
    
    
//    private func calculateDistance(newEntry: MeasurementEntry) -> Distance {
//        let lastEntry = data.last!
//        let distance = lastEntry.d + (newEntry.a - lastEntry.a)*((lastEntry.v+newEntry.v)/2)
//        return distance
//    }
    private func calculateDistanceX(newEntry: MeasurementEntryX) -> Double {
        let lastEntry = data.last!
        let distance = lastEntry.d + (newEntry.a - lastEntry.a)*((lastEntry.v+newEntry.v)/2)
        return distance
    }
    
    func getDistance() -> Double {
        return data.last!.d
    }
}






struct MeasurementEntryX {
    /// NSDate - time
    var t: NSDate
    
    var a: Double
    var v: Double
    
    /// Distance in meters
    var d: Double
    
    
    init() {
        a = 0.0
        v = 0.0
        d = 0.0
        t = NSDate()
    }
    
    var description:String {
        get {
            return "Acceleration: \(a)\n Velocity: \(v)\n Distance: \(d)"
        }
    }
}




struct MeasurementEntry {
    /// NSDate - time
    var t: NSDate
    
    var a: Acceleration
    var v: Velocity
    
    /// Distance in meters
    var d: Distance
    
    
    init() {
        a = Acceleration()
        v = Velocity()
        d = Distance()
        t = NSDate()
    }
    
    var description:String {
        get {
            return "Acceleration: \(a.description)\n Velocity: \(v.description)\n Distance: \(d.description)"
        }
    }
    
}



