//
//  Exponential.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation
import Tensor4iOS

public class Absolute: TransformExpression {

    public override var type: String {
        return ExpressionTypes.Absolute
    }

    static func evaluate(node: Expression) -> Tensor {
        let myNode = node as! TransformExpression
        let base = myNode.base.value
        return base.abs()
    }

    static func gradients(node: Expression, grad: Expression) -> [Expression] {
        let myNode = node as! TransformExpression
        let baseGrad = myNode.base.sign() * grad
        return [baseGrad]
    }
}
