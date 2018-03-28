//
//  Graph.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation
import Tensor4iOS

public class Graph {

    /// Name of the graph
    private var _name: String = ""
    public var name: String {
        return _name;
    }

    /// Dictionary of the nodes, key = node.id
    private var _nodes: [Int: Expression] = [:]
    public var nodes: [Int : Expression] {
        return _nodes
    }

    private var _factory: ExpressionFactory?
    internal var factory: ExpressionFactory {
        if (_factory == nil) {
            _factory = ExpressionFactory(self)
        }
        return _factory!
    }

    private var _session: Session?
    internal var session: Session? {
        get {
            return _session
        }
        set {
            _session = newValue
        }
    }

    /// Gets the node with id
    /// If not found return nil
    public subscript(id: Int) -> Expression? {
        return nodes[id]
    }

    public init(name: String) {
        _name = name
//        test()
    }

    /// Adds a node to this graph.
    /// Optionally return a node
    public func addNode(_ node: Expression) -> Expression {
        _nodes[node.id] = node
        return node
    }
}
