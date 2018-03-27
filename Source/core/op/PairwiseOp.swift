//
//  BinaryOp.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 27/03/2018.
//

import Foundation

public protocol PairwiseOp: Operation {

    func body(_ a: Float, _ b: Float) -> Float

}
