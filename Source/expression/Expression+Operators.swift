//
//  Expression-oo.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 25/03/2018.
//

import Foundation

extension Expression {

    public func add(_ other: Expression) -> Expression {
        return factory.add(self, other)
    }
    public static func +(left: Expression, right: Expression) -> Expression {
        return left.add(right)
    }

    public func subtract(_ other: Expression) -> Expression {
        return factory.subtract(self, other)
    }
    public static func -(left: Expression, right: Expression) -> Expression {
        return left.subtract(right)
    }

    public func multiply(_ other: Expression) -> Expression {
        return factory.multiply(self, other)
    }
    public static func *(left: Expression, right: Expression) -> Expression {
        return left.multiply(right)
    }

    public func divide(_ other: Expression) -> Expression {
        return factory.divide(self, other)
    }
    public static func /(left: Expression, right: Expression) -> Expression {
        return left.divide(right)
    }

    public func matmul(_ other: Expression, transposeLeft: Bool = false, transposeRight: Bool = false) -> Expression {
        return factory.matmul(self, other)
    }
    public static func *&(left: Expression, right: Expression) -> Expression {
        return left.matmul(right)
    }

    public func power(_ power: Int) -> Expression {
        return factory.power(self, power)
    }
    public static func **(left: Expression, right: Int) -> Expression {
        return left.power(right)
    }

    public func negate() -> Expression {
        return factory.negate(self)
    }
    public static prefix func -(base: Expression) -> Expression {
        return base.negate()
    }

    public func reduceSum(_ dimension: Int) -> Expression {
        return factory.reduceSum(self, dimension)
    }

    public func reduceSum(_ dimensions: [Int]) -> Expression {
        return factory.reduceSum(self, dimensions)
    }

    public func reshape(_ shape: [Int]) -> Expression {
        return factory.reshape(self, shape)
    }

    // Two Expression are absolutely equal if their IDs are equal.
    public static func ==(lhs: Expression, rhs: Expression) -> Bool {
        return lhs.id == rhs.id
    }

    /************ Transform ***************/

    public func abs() -> Expression {
        return factory.abs(self)
    }

    public func sin() -> Expression {
        return factory.sin(self)
    }

    public func cos() -> Expression {
        return factory.cos(self)
    }

    public func sign() -> Expression {
        return factory.sign(self)
    }

    public func exp() -> Expression {
        return factory.exp(self)
    }

    public func square() -> Expression {
        return factory.square(self)
    }
}
