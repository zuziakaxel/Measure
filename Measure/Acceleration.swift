//
//  Acceleration.swift
//  Measure
//
//  Created by Axel Zuziak on 08.11.2015.
//  Copyright © 2015 zuziakaxel. All rights reserved.
//

import Foundation
import CoreMotion

struct Acceleration: Vector {
    var x: AccelerationValue
    var y: AccelerationValue
    var z: AccelerationValue
    
    init() {
        self.x = AccelerationValue(value: 0.0, unit: .G)
        self.y = AccelerationValue(value: 0.0, unit: .G)
        self.z = AccelerationValue(value: 0.0, unit: .G)
    }
    
    init(x: Double, y: Double, z: Double = 0.0, unit: AccelerationUnit = .G) {
        self.x = AccelerationValue(value: x, unit: unit)
        self.y = AccelerationValue(value: y, unit: unit)
        self.z = AccelerationValue(value: z, unit: unit)
    }
    
    init(x: Double, y: Double, z: Double) {
        self.x = AccelerationValue(value: x, unit: .G)
        self.y = AccelerationValue(value: y, unit: .G)
        self.z = AccelerationValue(value: z, unit: .G)
    }
    
    init(acceleration: CMAcceleration) {
        self.x = AccelerationValue(value: acceleration.x, unit: .G)
        self.y = AccelerationValue(value: acceleration.y, unit: .G)
        self.z = AccelerationValue(value: acceleration.z, unit: .G)
    }
    
    var description:String {
        get {
            return "[\(x.value), \(x.value), \(x.value)]"
        }
    }
    
}



func +(left: Velocity, right: Acceleration) -> Velocity {
    let x = left.x.value + right.x.value
    let y = left.y.value + right.y.value
    let z = left.z.value + right.z.value
    
    return Velocity(x: x, y: y, z: z)
}
struct AccelerationValue: VectorValue {
    var value: Double
    var unit: AccelerationUnit = .G
    
    func getValue(desiredUnit: AccelerationUnit) -> Double {
        switch desiredUnit {
        case .G:
            if unit == .M_S_2 {
                return G_VALUE*value
            } else if unit == .G {
                return value
            }
        case .M_S_2:
            if unit == .M_S_2 {
                return value
            } else if unit == .G {
                return value/G_VALUE
            }
        }
        
        return value
    }
    
    init(value: Double, unit: AccelerationUnit) {
        self.value = value
        self.unit = unit
    }
    
    init(value: Double) {
        self.value = value
        self.unit = .G
    }
}

enum AccelerationUnit: Unit {
    case G
    case M_S_2
    var desc: String {
        get {
            switch self {
                case .M_S_2: return "Meters per Second square"
                case .G: return "G"
            }
        }
    }
}

public let G_VALUE: Double = 9.82