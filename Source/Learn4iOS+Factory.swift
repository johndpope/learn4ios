//
//  Learn4iOS+Factory.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 25/03/2018.
//

import Foundation

public func parameter(_ value: Tensor, name: String? = nil) -> Expression {
    return Learn4iOS.instance.factory.parameter(value, name: name)
}

public func variable(_ shape: [Int], name: String? = nil) -> Expression {
    return Learn4iOS.instance.factory.variable(shape, name: name)
}

public func add(_ left: Expression, _ right: Expression, name: String? = nil) -> Expression {
    return Learn4iOS.instance.factory.add(left, right, name: name)
}

public func subtract(_ left: Expression, _ right: Expression, name: String? = nil) -> Expression {
    return Learn4iOS.instance.factory.subtract(left, right, name: name)
}

public func multiply(_ left: Expression, _ right: Expression, name: String? = nil) -> Expression {
    return Learn4iOS.instance.factory.multiply(left, right, name: name)
}

public func divide(_ left: Expression, _ right: Expression, name: String? = nil) -> Expression {
    return Learn4iOS.instance.factory.divide(left, right, name: name)
}

public func abs(_ base: Expression, name: String? = nil) -> Expression {
    return Learn4iOS.instance.factory.abs(base, name: name)
}

public func exp(_ base: Expression, name: String? = nil) -> Expression {
    return Learn4iOS.instance.factory.exp(base, name: name)
}

public func reduceSum(_ base: Expression, _ dimension: Int = -1, name: String? = nil) -> Expression {
    return Learn4iOS.instance.factory.reduceSum(base, dimension, name: name)
}

public func gradients(_ target: Expression, _ nodes: [Expression]) -> [Expression] {
//    let visitor = ReverseGradientVisitor(Learn4iOS.activeGraph)
//    visitor.visit(target)

    var gradients: [Expression] = []

    for node in nodes {

        // BUG: If one node is not differentiable, should have returned nil
        if let grad = target.getGradient(node) {
            gradients.append(grad)
        }
        //        if (this.interactive) {
        //            grad.eval();
        //        }

    }

    return gradients
}
