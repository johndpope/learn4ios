//
//  Tensor.swift
//  learn4ios
//
//  Created by Guangmiao Luan on 20/02/2018.
//

import Foundation

extension Tensor {

    /**************** Arithmetic *******************/

    public func add(_ other: Tensor) -> Tensor {
        return TensorMath.add(self, other)
    }
    public static func + (left: Tensor, right: Tensor) -> Tensor {
        return left.add(right)
    }

    public func subtract(_ other: Tensor) -> Tensor {
        return TensorMath.subtract(self, other)
    }
    public static func - (left: Tensor, right: Tensor) -> Tensor {
        return left.subtract(right)
    }

    public func multiply(_ other: Tensor) -> Tensor {
        return TensorMath.multiply(self, other)
    }
    public static func * (left: Tensor, right: Tensor) -> Tensor {
        return left.multiply(right)
    }

    public func divide(_ other: Tensor) -> Tensor {
        return TensorMath.divide(self, other)
    }
    public static func / (left: Tensor, right: Tensor) -> Tensor {
        return left.divide(right)
    }

    public func matmul(_ other: Tensor) -> Tensor {
        return TensorMath.matmul(self, other)
    }
    public static func *& (left: Tensor, right: Tensor) -> Tensor {
        return left.matmul(right)
    }

    /************* Transforms ****************/

    public func abs() -> Tensor {
        return TensorMath.abs(self)
    }

    public func exp() -> Tensor {
        return TensorMath.exp(self)
    }

    public func sin() -> Tensor {
        return TensorMath.sin(self)
    }

    public func cos() -> Tensor {
        return TensorMath.cos(self)
    }

    public func square() -> Tensor {
        return TensorMath.square(self)
    }

    public func negate() -> Tensor {
        return TensorMath.negate(self)
    }

    public func sign() -> Tensor {
        return TensorMath.negate(self)
    }

    /************* Reduction *****************/
    public func reduceSum(_ dimension: Int = -1) -> Tensor {
        return TensorMath.reduceSum(self, dimension)
    }

    public func reduceSum(_ dimensions: [Int]) -> Tensor {
        return TensorMath.reduceSum(self, dimensions)
    }

    /************* Special ******************/
    // Modify self
    public func fill(_ scalar: Float) {
        let _ = TensorMath.set(self, scalar, self)
    }

}
