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

    private static var _graph: Graph = Graph(name: "DEFAULT")
    public static var activeGraph: Graph {
        get {
            return _graph
        }
        set {
            _graph = newValue
        }
    }

    private static var _sess: Session? = nil
    public static var activeSession: Session {
        get {
            if (_sess == nil) {
                _sess = Session(_graph)
                _graph.session = _sess
            }
            return _sess!
        }
        set {
            _sess = newValue
        }
    }

    static var factory: ExpressionFactory {
        get {
            return activeGraph.factory
        }
    }

    init() {

    }

}
