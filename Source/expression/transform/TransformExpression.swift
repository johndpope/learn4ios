//
//  TransformExpression.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation

public class TransformExpression: Expression {

    private var _base: Expression
    public var base: Expression {
        return _base
    }

    public override var shape: [Int] {
        return base.shape
    }

    public override var dependencies: [Expression] {
        return [base]
    }

    init(_ base: Expression, graph: Graph, name: String? = nil) {
        _base = base
        super.init(graph: graph, name: name)
    }
}
