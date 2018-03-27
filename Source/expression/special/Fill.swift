//
//  Fill.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 26/02/2018.
//

import Foundation

public class Fill: Expression {

    public override var type: String {
        return ExpressionTypes.Fill
    }

    private var _scalar: Float
    public var scalar: Float {
        return _scalar
    }

    private var _shape: [Int]
    public override var shape: [Int] {
        return _shape
    }

    public init(_ scalar: Float, _ shape: [Int], graph: Graph, name: String? = nil) {
        _scalar = scalar
        _shape = shape
        super.init(graph: graph, name: name)
    }

}
