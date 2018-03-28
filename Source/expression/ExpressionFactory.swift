//
//  ExpressionFactory.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation
import Tensor4iOS

class ExpressionFactory {

    var graph: Graph

    init(_ graph: Graph) {
        self.graph = graph
    }

    func add(_ left: Expression, _ right: Expression, name: String? = nil) -> Expression {
        return graph.addNode(Add(left, right, graph: graph, name: name))
    }

    func subtract(_ left: Expression, _ right: Expression, name: String? = nil) -> Expression {
        return graph.addNode(Subtract(left, right, graph: graph, name: name))
    }

    func multiply(_ left: Expression, _ right: Expression, name: String? = nil) -> Expression {
        return graph.addNode(Multiply(left, right, graph: graph, name: name))
    }

    func divide(_ left: Expression, _ right: Expression, name: String? = nil) -> Expression {
        return graph.addNode(Divide(left, right, graph: graph, name: name))
    }

    func matmul(_ left: Expression, _ right: Expression, _ transposeLeft: Bool = false, _ transposeRight: Bool = false, name: String? = nil) -> Expression {
        return graph.addNode(MatMul(left, right, graph: graph, name: name))
    }

    func variable(_ shape: [Int], name: String? = nil) -> Expression {
        return graph.addNode(Variable(shape, graph: graph, name: name))
    }

    func parameter(_ value: Tensor, name: String? = nil) -> Expression {
        return graph.addNode(Parameter(value, graph: graph, name: name))
    }

    func exp(_ base: Expression, name: String? = nil) -> Expression {
        return graph.addNode(Exponential(base, graph: graph, name: name))
    }

    func reduceSum(_ base: Expression, _ dimension: Int, name: String? = nil) -> Expression {
        return graph.addNode(ReduceSum(base, dimension, graph: graph, name: name))
    }

    func reduceSum(_ base: Expression, _ dimensions: [Int], name: String? = nil) -> Expression {
        return graph.addNode(ReduceSum(base, dimensions, graph: graph, name: name))
    }

    func reshape(_ base: Expression, _ shape: [Int], name: String? = nil) -> Expression {
        if (ShapeUtils.shapeEquals(base.shape, shape)) {
            return base
        }
        return graph.addNode(Reshape(base, shape, graph: graph, name: name))
    }

    func abs(_ base: Expression, name: String? = nil) -> Expression {
        return graph.addNode(Absolute(base, graph: graph, name: name))
    }

    func sin(_ base: Expression, name: String? = nil) -> Expression {
        return graph.addNode(Sine(base, graph: graph, name: name))
    }

    func cos(_ base: Expression, name: String? = nil) -> Expression {
        return graph.addNode(Cosine(base, graph: graph, name: name))
    }

    func negate(_ base: Expression, name: String? = nil) -> Expression {
        return graph.addNode(Negate(base, graph: graph, name: name))
    }

    func power(_ base: Expression, _ power: Int, name: String? = nil) -> Expression {
        if (power == 2) {
            return graph.addNode(Square(base, graph: graph, name: name))
        }

        return graph.addNode(Power(base, power, graph: graph, name: name))
    }

    func fill(_ scalar: Float, _ shape: [Int], name: String? = nil) -> Expression {
        return graph.addNode(Fill(scalar, shape, graph: graph, name: name))
    }
    
    func sign(_ base: Expression, name: String? = nil) -> Expression {
        return graph.addNode(Sign(base, graph: graph, name: name))
    }

    func square(_ base: Expression, name: String? = nil) -> Expression {
        return graph.addNode(Square(base, graph: graph, name: name))
    }

    func addN(_ list: [Expression], name: String? = nil) -> Expression {
        if (list.count == 1) {
            return list[0]
        }

        return graph.addNode(AddN(list, graph: graph, name: name))
    }
}
