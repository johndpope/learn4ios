//
//  ReductionExpression.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 25/02/2018.
//

import Foundation

public class ReductionExpression: Expression {

    private var _base: Expression
    public var base: Expression {
        return _base
    }

    private var _dimensions: [Int]
    public var dimensions: [Int] {
        return _dimensions
    }

    private var _shape: [Int]
    public override var shape: [Int] {
        return _shape
    }

    public override var dependencies: [Expression] {
        return [base]
    }

    init(_ base: Expression, _ dimension: Int = -1, graph: Graph, name: String? = nil) {
        _base = base
        _dimensions = [dimension]
        _shape = ShapeUtils.reduceShape(base.shape, dimension)
        super.init(graph: graph, name: name)
    }

    init(_ base: Expression, _ dimensions: [Int], graph: Graph, name: String? = nil) {
        _base = base
        _dimensions = dimensions
        _shape = ShapeUtils.reduceShape(base.shape, dimensions)
        super.init(graph: graph, name: name)
    }
}
