//
//  BinaryExpression.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation

public class BinaryExpression: Expression {

    private var _left: Expression
    public var left: Expression {
        return _left
    }

    private var _right: Expression
    public var right: Expression {
        return _right
    }

    public override var dependencies: [Expression] {
        return [left, right]
    }

    init(_ left: Expression, _ right: Expression, graph: Graph, name: String? = nil) {
        _left = left
        _right = right
        super.init(graph: graph, name: name)
    }
}
