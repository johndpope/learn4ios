//
//  ReverseGradientVisitor.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 26/02/2018.
//

import Foundation

public class ReverseGradientVisitor: Visitor {

    private var _registry: [String : (Expression, Expression) -> [Expression]]
    public var registry: [String : (Expression, Expression) -> [Expression]] {
        get {
            return _registry
        }
    }
    
    // key = id, value = list of grads
    private var _gradMap: [Int: [Expression]] = [:]

    private var _graph: Graph
    public var graph: Graph {
        get {
            return _graph
        }
    }

    var factory: ExpressionFactory {
        return _graph.factory
    }

    private var _startId: Int = 0

    init(_ graph: Graph) {
        _graph = graph
        _registry = [:]
    }

    public func register(_ type: String, _ method: @escaping (Expression, Expression) -> [Expression]) {
        _registry[type] = method
    }

    public func visit(_ node: Expression, _ params: Any?) {
        // initialize
        if (_startId == 0) {
            _startId = node.id
            _gradMap = [:]
        }

        // body
        var grad = (params as? Expression) ?? factory.fill(1, node.shape)
        grad = _graph.addNode(grad)
        addGradient(node, grad)

        if let method = registry[node.type] {
            let grads = method(node, grad)

            for i in 0..<node.dependencies.count {
                node.dependencies[i].accept(self, grads[i])
            }
        }

        // finalize
        if (_startId == node.id) {
            for (key, list) in _gradMap {
                let addN = factory.addN(list)
                node.setGradient(key, addN)
            }
            _startId = 0
            _gradMap = [:]
        }
    }

    private func registerDefault() {
        register(ExpressionTypes.Add, Add.gradients)
        register(ExpressionTypes.Divide, Divide.gradients)
        register(ExpressionTypes.Multiply, Multiply.gradients)
        register(ExpressionTypes.Subtract, Subtract.gradients)
        register(ExpressionTypes.MatMul, MatMul.gradients)

        register(ExpressionTypes.Absolute, Absolute.gradients)
        register(ExpressionTypes.Cosine, Cosine.gradients)
        register(ExpressionTypes.Sine, Sine.gradients)
        register(ExpressionTypes.Exponential, Exponential.gradients)
        register(ExpressionTypes.Negate, Negate.gradients)
    }

    private func addGradient(_ node: Expression, _ grad: Expression) {
        var list: [Expression] = _gradMap[node.id] ?? []
        list.append(grad)
        _gradMap[node.id] = list
    }


    //
    //    public func visitVariable(_ node: Variable, _ params: Any?) {
    //        let _ = preVisit(node, params)
    //    }
    //
    //
    //    public func visitExponential(_ node: Exponential, _ params: Any?) {
    //        let grad = preVisit(node, params)
    //        let baseGrad = grad * node
    //        node.base.accept(self, baseGrad)
    //    }
    //
    //    public func visitAbsolute(_ node: Absolute, _ params: Any?) {
    //        let grad = preVisit(node, params)
    //        let sign = factory.sign(node.base)
    //        let baseGrad = grad * sign
    //        node.base.accept(self, baseGrad)
    //    }
    //
    //    public func visitParameter(_ node: Parameter, _ params: Any?) {
    //        let _ = preVisit(node, params)
    //    }
    //
    //    public func visitSquare(_ node: Square, _ params: Any?) {
    //        let grad = preVisit(node, params)
    ////        let two = this.factory.constant(Tensor.scalar(2))
    ////        let mul = this.factory.multiply(two, node.base);
    ////        let result = this.factory.multiply(grad, mul);
    //        let baseGrad = grad * node.base // TODO: 2 *
    //
    //        node.base.accept(self, baseGrad)
    //    }
    //
    //    public func visitReduceSum(_ node: ReduceSum, _ params: Any?) {
    //
    //    }
    //
    //    public func visitPower(_ node: Power, _ params: Any?) {
    //
    //    }
    //
    //    public func visitFill(_ node: Fill, _ params: Any?) {
    //
    //    }
    //
    //    public func visitNegate(_ node: Negate, _ params: Any?) {
    //        let grad = preVisit(node, params)
    //        let baseGrad = -grad
    //        node.base.accept(self, baseGrad)
    //    }
    //
    //    public func visitSign(_ node: Sign, _ params: Any?) {
    //
    //    }
}
