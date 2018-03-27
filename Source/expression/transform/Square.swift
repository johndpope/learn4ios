//
//  Exponential.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation

public class Square: TransformExpression {

    public override var type: String {
        return ExpressionTypes.Square
    }

    static func evaluate(node: Expression) -> Tensor {
        let myNode = node as! TransformExpression
        let base = myNode.base.value
        return base.square()
    }
}
