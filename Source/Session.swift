//
//  Session.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation
import Tensor4iOS

/// A Session is used to evaluate a graph independent of the graph itself
public class Session {

    /// Stores whether the node is evaluated and valid
    private var stateMap: [Int: Bool] = [:]

    /// Stores the tensor values of nodes
    private var valueMap: [Int: Tensor] = [:]

    private var _graph: Graph
    public var graph: Graph {
        return _graph
    }

    public subscript(node: Expression) -> Tensor {
        get {
            return getValue(node)!
        }
        set {
            setValue(node, newValue)
        }
    }

    public init(_ graph: Graph) {
        _graph = graph
    }

    public func eval(_ node: Expression) -> Tensor {
        let visitor = EvaluationVisitor(self)
        node.accept(visitor)
        return getValue(node)!
    }

    public func getValue(_ node: Expression) -> Tensor? {
        return valueMap[node.id]
    }

    /// Set the value of the node to the given tensor.
    /// This SHOULD cause all of its observers to be invalidated
    public func setValue(_ node: Expression, _ value: Tensor) {
        valueMap[node.id] = value
        invalidateObservers(node)
        stateMap[node.id] = true
    }

    public func isValid(_ node: Expression) -> Bool {
        return stateMap[node.id] ?? false
    }

    internal func invalidateObservers(_ node: Expression) {
        for observer in node.observers {
            // only need to trigger invalidation of nodes that are previously validated
            // Also helps to prevent circular reference infinite loop
            if (isValid(observer)) {
                stateMap[observer.id] = false   // invalidate self
                invalidateObservers(observer)   // invalidate its observers
            }
        }
    }
}
