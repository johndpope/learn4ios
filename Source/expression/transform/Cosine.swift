//
//  Exponential.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation

public class Cosine: TransformExpression {

    public override var type: String {
        return ExpressionTypes.Cosine
    }

    static func evaluate(node: Expression) -> Tensor {
        let myNode = node as! TransformExpression
        let base = myNode.base.value
        return base.cos()
    }

    static func gradients(node: Expression, grad: Expression) -> [Expression] {
        let myNode = node as! TransformExpression
        let baseGrad = -myNode.base.sin() * grad
        return [baseGrad]
    }
}
