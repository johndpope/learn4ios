//
//  Fill.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 26/02/2018.
//

import Foundation

public class AddN: Expression {

    public override var type: String {
        return ExpressionTypes.AddN
    }

    private var _list: [Expression]
    public var list: [Expression] {
        return _list
    }

    public override var shape: [Int] {
        return list[0].shape
    }

    public init(_ list: [Expression], graph: Graph, name: String? = nil) {
        _list = list
        super.init(graph: graph, name: name)
    }

}
