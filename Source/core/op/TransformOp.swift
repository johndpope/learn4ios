//
//  BinaryOp.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 27/03/2018.
//

import Foundation

public protocol TransformOp: Operation {

    func body(_ a: Float) -> Float

}
