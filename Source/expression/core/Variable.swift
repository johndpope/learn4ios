//
//  Variable.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation

public class Variable: Expression {

    public override var type: String {
        return ExpressionTypes.Variable
    }

    private var _shape: [Int]
    public override var shape: [Int] {
        return _shape
    }

    init(_ shape: [Int], graph: Graph, name: String?) {
        _shape = shape
        super.init(graph: graph, name: name)
    }

}
