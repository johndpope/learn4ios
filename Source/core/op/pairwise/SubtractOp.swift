//
//  SubtractOp.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 22/02/2018.
//

import Foundation

public class SubtractOp: PairwiseOp {

    private var _input: Tensor
    public var input: Tensor {
        return _input
    }

    private var _other: Tensor
    public var other: Tensor {
        return _other
    }

    private var _result: Tensor
    public var result: Tensor {
        return _result
    }

    public var isSpecial: Bool {
        return false
    }

    public init(_ input: Tensor, _ other: Tensor, _ result: Tensor) {
        _input = input
        _other = other
        _result = result
    }

    public func body(_ a: Float, _ b: Float) -> Float {
        return a - b
    }

    public func exec() { }
}
