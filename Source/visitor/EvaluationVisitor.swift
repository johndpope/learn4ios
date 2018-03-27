//
//  EvaluationVisitor.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 21/02/2018.
//

import Foundation

/// Used to evaluate a graph.
/// Must be created with a session
/// EvaluationVisitor reads and writes to a session
public class EvaluationVisitor: Visitor {

    private var _registry: [String : (Expression) -> Tensor]
    public var registry: [String : (Expression) -> Tensor] {
        get {
            return _registry
        }
    }

    private var _session: Session
    var session: Session {
        return _session
    }
    
    public init(_ session: Session) {
        _session = session
        _registry = [:]
        registerDefault()
    }

    public func visit(_ node: Expression, _ params: Any? = nil) {
        if (session.isValid(node)) {
            return;
        }

        if let method = registry[node.type] {
            for dependency in node.dependencies {
                dependency.accept(self, params)
            }
            
            session[node] = method(node)
        }
    }

    public func register(_ type: String, _ method: @escaping (Expression) -> Tensor) {
        _registry[type] = method
    }

    private func registerDefault() {
        register(ExpressionTypes.Parameter, Parameter.evaluate)

        register(ExpressionTypes.Add, Add.evaluate)
        register(ExpressionTypes.Subtract, Subtract.evaluate)
        register(ExpressionTypes.Multiply, Multiply.evaluate)
        register(ExpressionTypes.Divide, Divide.evaluate)
        register(ExpressionTypes.MatMul, MatMul.evaluate)

        register(ExpressionTypes.ReduceSum, ReduceSum.evaluate)

        register(ExpressionTypes.Absolute, Absolute.evaluate)
        register(ExpressionTypes.Exponential, Exponential.evaluate)
        register(ExpressionTypes.Negate, Negate.evaluate)
        register(ExpressionTypes.Sign, Sign.evaluate)
        register(ExpressionTypes.Square, Square.evaluate)
    }

    func visitFill(_ node: Fill, _ params: Any?) {
        if (session.isValid(node)) {
            return
        }

        session[node] = Tensor(scalar: node.scalar, shape: node.shape)
    }

}
