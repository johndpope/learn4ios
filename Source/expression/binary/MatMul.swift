//
//  MatMul.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation
import Tensor4iOS

public class MatMul: BinaryExpression {

    public override var type: String {
        return ExpressionTypes.MatMul
    }

    private var _shape: [Int]
    public override var shape: [Int] {
        return _shape
    }

    private var _transposeLeft: Bool
    public var transposeLeft: Bool {
        return _transposeLeft
    }

    private var _transposeRight: Bool
    public var transposeRight: Bool {
        return _transposeRight
    }

    init(_ left: Expression, _ right: Expression, _ transposeLeft: Bool = false, _ transposeRight: Bool = false, graph: Graph, name: String?) {
        _shape = [left.shape[0], right.shape[1]]
        _transposeLeft = transposeLeft
        _transposeRight = transposeRight
        super.init(left, right, graph: graph, name: name)
    }

    static func evaluate(node: Expression) -> Tensor {
        let myNode = node as! BinaryExpression
        let left = myNode.left.value
        let right = myNode.right.value
        return left *& right
    }

    static func gradients(node: Expression, grad: Expression) -> [Expression] {
        let myNode = node as! BinaryExpression
        let leftGrad = grad.matmul(myNode.right, transposeLeft: false, transposeRight: true)
        let rightGrad = myNode.left.matmul(grad, transposeLeft: true, transposeRight: false)
        return [leftGrad, rightGrad]
    }
}
