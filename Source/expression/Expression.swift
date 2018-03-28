//
//  Expression.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation
import Tensor4iOS

public class Expression : CustomStringConvertible, Hashable {
    
    static var ID_COUNTER: Int = 0;
    
    private var _id: Int
    private var _name: String? = nil
    private var _graph: Graph
    private lazy var _gradients: [Int: Expression] = [:]
    private lazy var _observers: [Expression] = []
    
    public var id: Int {
        return _id;
    }

    public var name: String {
        if (_name == nil || _name!.isEmpty) {
            return type + "_" + String(id)
        }
        return _name!
    }

    public var graph: Graph {
        return _graph
    }

    /// Value property returns the value of this expression in the activeSession
    /// Get operator will trigger an Eval
    /// Set operator will trigger invalidation
    public var value: Tensor {
        get {
            if (!graph.session!.isValid(self)) {
                return graph.session!.eval(self)
            }
            return graph.session!.getValue(self)!
        }
        set {
            graph.session!.setValue(self, newValue)
        }
    }
    
    public var type: String {
        assert(false, "Expession.type should not be called from base class")
        return ExpressionTypes.Unknown
    }
    
    public var description: String {
        return name
    }
    
    public var shape: [Int] {
        assert(false, "Expession.shape should not be called from base class")
        return [0]
    }
    
    public var hashValue: Int {
        // NOTE: possible overflow
        var hash = type.hashValue &* 31
        if (_name != nil) {
            hash = hash &+ _name!.hashValue
        }
        return hash
    }
    
    /// A list of expressions observing changes
    public var observers: [Expression] {
        return _observers
    }

    public var dependencies: [Expression] {
        return []
    }

    internal var factory: ExpressionFactory {
        return _graph.factory
    }

    // internal to prevent initiation
    init(graph: Graph, name: String? = nil) {
        Expression.ID_COUNTER += 1
        self._id = Expression.ID_COUNTER
        self._graph = graph
        self._name = name
    }
    
    public func accept(_ visitor: Visitor, _ params: Any? = nil) {
        visitor.visit(self, params)
    }
    
    public func addObserver(_ observer: Expression) {
        _observers.append(observer)
    }
    
    public func getGradient(_ target: Expression) -> Expression? {
        return _gradients[target.id]
    }
    
    public func setGradient(_ targetId: Int, _ gradient: Expression) {
        _gradients[targetId] = gradient
    }
    
    
}
