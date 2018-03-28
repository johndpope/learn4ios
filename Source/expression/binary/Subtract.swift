//
//  Add.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation
import Tensor4iOS

public class Subtract: BinaryExpression {

    public override var type: String {
        return ExpressionTypes.Subtract
    }
    
    private var _shape: [Int]
    public override var shape: [Int] {
        return _shape
    }

    override init(_ left: Expression, _ right: Expression, graph: Graph, name: String?) {
        _shape = ShapeUtils.broadcastShapes(left.shape, right.shape)
        super.init(left, right, graph: graph, name: name)
    }

    static func evaluate(node: Expression) -> Tensor {
        let myNode = node as! BinaryExpression
        let left = myNode.left.value
        let right = myNode.right.value
        return left - right
    }

    static func gradients(node: Expression, grad: Expression) -> [Expression] {
        let myNode = node as! BinaryExpression
        let pair = ShapeUtils.getReductionIndices(myNode.left.shape, myNode.right.shape)
        let leftGrad = grad.reduceSum(pair.left).reshape(myNode.left.shape)
        let rightGrad = grad.reduceSum(pair.right).negate().reshape(myNode.right.shape)
        return [leftGrad, rightGrad]
    }
}
