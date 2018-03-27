//
//  Parameter.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 23/02/2018.
//

import Foundation

public class Constant: Expression {

    public override var type: String {
        return ExpressionTypes.Constant
    }

    private var _value: Tensor
    public override var value: Tensor {
        get {
            return _value
        }
        set {
            assert(false, "Cannot set constant's value")
        }
    }

    public override var shape: [Int] {
        return _value.shape
    }

    init(_ value: Tensor, graph: Graph, name: String? = nil) {
        _value = value
        super.init(graph: graph, name: name)
    }

    static func evaluate(node: Expression) -> Tensor {
        let myNode = node as! Constant
        return myNode.value
    }
}
