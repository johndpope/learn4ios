//
//  Parameter.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 23/02/2018.
//

import Foundation
import Tensor4iOS

public class Parameter: Expression {

    public override var type: String {
        return ExpressionTypes.Parameter
    }

    private var _initialValue: Tensor
    public var initialValue: Tensor {
        return _initialValue
    }

    public override var shape: [Int] {
        return _initialValue.shape
    }

    init(_ initialValue: Tensor, graph: Graph, name: String? = nil) {
        _initialValue = initialValue
        super.init(graph: graph, name: name)
    }

    static func evaluate(node: Expression) -> Tensor {
        let myNode = node as! Parameter
        return myNode.initialValue
    }
}
