//
//  Fill.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 26/02/2018.
//

import Foundation
import Tensor4iOS

public class Reshape: Expression {

    public override var type: String {
        return ExpressionTypes.Reshape
    }

    private var _base: Expression
    public var base: Expression {
        return _base
    }

    private var _shape: [Int]
    public override var shape: [Int] {
        return _shape
    }

    public init(_ base: Expression, _ shape: [Int], graph: Graph, name: String? = nil) {
        _base = base
        _shape = shape
        super.init(graph: graph, name: name)
    }

    static func evaluate(node: Expression) -> Tensor {
        let myNode = node as! Reshape
        let base = myNode.base.value
        return base.reshape(myNode.shape)
    }
    
}
