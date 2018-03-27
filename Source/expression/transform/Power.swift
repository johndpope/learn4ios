//
//  Exponential.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation

public class Power: TransformExpression {

    public override var type: String {
        return ExpressionTypes.Power
    }

    private var _power: Int
    public var power:Int {
        return _power
    }

    init(_ base: Expression, _ power: Int, graph: Graph, name: String? = nil) {
        _power = power
        super.init(base, graph: graph, name: name)
    }

}
