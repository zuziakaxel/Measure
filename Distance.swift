//
//  Distance.swift
//  Measure
//
//  Created by Axel Zuziak on 08.11.2015.
//  Copyright © 2015 zuziakaxel. All rights reserved.
//

import UIKit


struct Distance: Vector {
    var x: DistanceValue
    var y: DistanceValue
    var z: DistanceValue
    
    init() {
        self.x = DistanceValue(value: 0.0, unit: .M)
        self.y = DistanceValue(value: 0.0, unit: .M)
        self.z = DistanceValue(value: 0.0, unit: .M)
    }
    
    init(x: Double, y: Double, z: Double = 0.0, unit: DistanceUnit = .M) {
        self.x = DistanceValue(value: x, unit: unit)
        self.y = DistanceValue(value: y, unit: unit)
        self.z = DistanceValue(value: z, unit: unit)
    }
    
    init(x: Double, y: Double, z: Double) {
        self.x = DistanceValue(value: x, unit: .M)
        self.y = DistanceValue(value: y, unit: .M)
        self.z = DistanceValue(value: z, unit: .M)
    }
    
    var description:String {
        get {
            return "[\(x.value), \(x.value), \(x.value)]"
        }
    }
    
    var magnitude: Double {
        return sqrt(x.value*y.value)
    }
    
}

struct DistanceValue: VectorValue {
    var value: Double
    var unit: DistanceUnit = .M
    
    func getValue(desiredUnit: DistanceUnit) -> Double {
        switch desiredUnit {
        case .M:
            if unit == .M {
                return value
            } else if unit == .CM {
                return value/100.0
            }
        case .CM:
            if unit == .CM {
                return value
            } else if unit == .M {
                return value*100.0
            }
        }
        
        return value
    }
    
    init(value: Double, unit: DistanceUnit) {
        self.value = value
        self.unit = unit
    }
    
    init(value: Double) {
        self.value = value
        self.unit = .M
    }
}

enum DistanceUnit: Unit {
    case M
    case CM
    var desc: String {
        get {
            switch self {
            case .M: return "Meters"
            case .CM: return "CentiMeters"
            }
        }
    }
}