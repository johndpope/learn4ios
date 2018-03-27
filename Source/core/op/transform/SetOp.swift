//
//  AddOp.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 21/02/2018.
//

import Foundation

public class SetOp: TransformOp {
    
    private var _input: Tensor
    public var input: Tensor {
        return _input
    }

    public var other: Tensor {
        return _input
    }

    private var _result: Tensor
    public var result: Tensor {
        return _result
    }

    public var isSpecial: Bool {
        return false
    }

    public init(_ input: Tensor, _ result: Tensor) {
        _input = input
        _result = result
    }

    public func body(_ a: Float) -> Float {
        return a
    }

    public func exec() {

    }
}
