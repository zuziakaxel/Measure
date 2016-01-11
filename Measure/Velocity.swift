//
//  Velocity.swift
//  Measure
//
//  Created by Axel Zuziak on 08.11.2015.
//  Copyright © 2015 zuziakaxel. All rights reserved.
//

import Foundation


struct Velocity: Vector {
    var x: VelocityValue
    var y: VelocityValue
    var z: VelocityValue
    
    init(x: Double, y: Double, z: Double) {
        self.x = VelocityValue(value: x, unit: .M_S)
        self.y = VelocityValue(value: y, unit: .M_S)
        self.z = VelocityValue(value: z, unit: .M_S)
    }
    
    init() {
        self.x = VelocityValue(value: 0.0, unit: .M_S)
        self.y = VelocityValue(value: 0.0, unit: .M_S)
        self.z = VelocityValue(value: 0.0, unit: .M_S)
    }
    
    var description:String {
        get {
            return "[\(x.value), \(x.value), \(x.value)]"
        }
    }
}


struct VelocityValue: VectorValue {
    var value: Double
    var unit: VelocityUnit
    
    func getValue(desiredUnit: VelocityUnit) -> Double {
        return value
    }
    
    init(value: Double, unit: VelocityUnit = .M_S) {
        self.value = value
        self.unit = unit
    }
    
    init(value: Double) {
        self.value = value
        self.unit = .M_S
    }
}


enum VelocityUnit: Unit {
    case M_S
    var desc: String {
        get {
            switch self {
                case .M_S: return "Meters per Second"
            }
        }
    }
}