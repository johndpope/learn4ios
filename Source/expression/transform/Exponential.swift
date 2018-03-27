//
//  Exponential.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation

public class Exponential: TransformExpression {

    public override var type: String {
        return ExpressionTypes.Exponential
    }

    static func evaluate(node: Expression) -> Tensor {
        let myNode = node as! TransformExpression
        let base = myNode.base.value
        return base.exp()
    }

    static func gradients(node: Expression, grad: Expression) -> [Expression] {
        let baseGrad = node * grad
        return [baseGrad]
    }
}
