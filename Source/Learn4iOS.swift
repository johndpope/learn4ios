//
//  Learn4ios.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation

// This is for matmul. Since swift cannot use @ as part of the operator name...
infix operator *&: MultiplicationPrecedence

// Power operator
infix operator **: MultiplicationPrecedence

public class Learn4iOS {

    public static var instance = Learn4iOS()
    
    private var _graph: Graph
    public var activeGraph: Graph {
        get {
            return _graph
        }
        set {
            _graph = newValue
        }
    }

    private var _sess: Session
    public var activeSession: Session {
        get {
            return _sess
        }
        set {
            _sess = newValue
        }
    }

    var factory: ExpressionFactory {
        get {
            return activeGraph.factory
        }
    }

    init() {
        _graph = Graph(name: "Default")
        _sess = Session(_graph)
        _graph.session = _sess
    }

}
