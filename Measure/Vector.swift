//
//  Vector.swift
//  Measure
//
//  Created by Axel Zuziak on 08.11.2015.
//  Copyright © 2015 zuziakaxel. All rights reserved.
//

import Foundation
import UIKit

protocol Vector {
    typealias Vv: VectorValue
    var x: Vv { get set }
    var y: Vv { get set }
    var z: Vv { get set }
    init(x: Double, y: Double, z: Double)
    var description:String { get }
}

func +<V:Vector>(left: V, right: V) -> V {
    let x = left.x.value + right.x.value
    let y = left.y.value + right.y.value
    let z = left.z.value + right.z.value

    return V(x: x, y: y, z: z)
}

func +<V:Vector, SV:Vector>(left: SV, right: V) -> SV {
    let x = left.x.value + right.x.value
    let y = left.y.value + right.y.value
    let z = left.z.value + right.z.value
    
    return SV(x: x, y: y, z: z)
}


func -<V:Vector>(left: V, right: V) -> V {
    let x = left.x.value - right.x.value
    let y = left.y.value - right.y.value
    let z = left.z.value - right.z.value
    
    return V(x: x, y: y, z: z)
}

func -<V:Vector, SV: Vector>(left: SV, right: V) -> SV {
    let x = left.x.value - right.x.value
    let y = left.y.value - right.y.value
    let z = left.z.value - right.z.value
    
    return SV(x: x, y: y, z: z)
}

func *<V:Vector>(left:Double , right: V) -> V {
    let x = right.x.value * left
    let y = right.y.value * left
    let z = right.z.value * left
    
    return V(x: x, y: y, z: z)
}

func *<V:Vector>(left:V , right: V) -> V {
    let x = right.x.value * left.x.value
    let y = right.y.value * left.y.value
    let z = right.z.value * left.z.value
    
    return V(x: x, y: y, z: z)
}

func *<V:Vector,SV:Vector>(left:SV , right: V) -> SV {
    let x = right.x.value * left.x.value
    let y = right.y.value * left.y.value
    let z = right.z.value * left.z.value
    
    return SV(x: x, y: y, z: z)
}

func /<V:Vector>(left:V , right: Double) -> V {
    let x = left.x.value / right
    let y = left.y.value / right
    let z = left.z.value / right
    
    return V(x: x, y: y, z: z)
}



protocol VectorValue {
    typealias U: Unit
    var value: Double { get set }
    var unit: U { get set }
    init(value: Double)
}

protocol Unit {
    var desc: String {get}
}