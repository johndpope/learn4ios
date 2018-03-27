//
//  ReduceSum.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 25/02/2018.
//

import Foundation

public class ReduceSum: ReductionExpression {

    public override var type: String {
        return ExpressionTypes.ReduceSum
    }

    static func evaluate(node: Expression) -> Tensor {
        let myNode = node as! ReductionExpression
        let base = myNode.base.value
        return base.reduceSum(myNode.dimensions)
    }
}
