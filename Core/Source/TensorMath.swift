//
// Created by Luan Guangmiao on 20/02/2018.
//

import Foundation

public class TensorMath {

    public static func add(_ left: Tensor, _ right: Tensor, _ result: Tensor? = nil) -> Tensor {
        let shape = result?.shape ?? ShapeUtils.broadcastShapes(left.shape, right.shape)
        let result = result ?? Tensor(shape: shape)
        let left = left.broadcast(shape)
        let right = right.broadcast(shape)
        Executor.exec(AddOp(left, right, result))
        return result
    }

    public static func subtract(_ left: Tensor, _ right: Tensor, _ result: Tensor? = nil) -> Tensor {
        let shape = result?.shape ?? ShapeUtils.broadcastShapes(left.shape, right.shape)
        let result = result ?? Tensor(shape: shape)
        let left = left.broadcast(shape)
        let right = right.broadcast(shape)
        Executor.exec(SubtractOp(left, right, result))
        return result
    }

    public static func multiply(_ left: Tensor, _ right: Tensor, _ result: Tensor? = nil) -> Tensor {
        let shape = result?.shape ?? ShapeUtils.broadcastShapes(left.shape, right.shape)
        let result = result ?? Tensor(shape: shape)
        let left = left.broadcast(shape)
        let right = right.broadcast(shape)
        Executor.exec(MultiplyOp(left, right, result))
        return result
    }

    public static func divide(_ left: Tensor, _ right: Tensor, _ result: Tensor? = nil) -> Tensor {
        let shape = result?.shape ?? ShapeUtils.broadcastShapes(left.shape, right.shape)
        let result = result ?? Tensor(shape: shape)
        let left = left.broadcast(shape)
        let right = right.broadcast(shape)
        Executor.exec(DivideOp(left, right, result))
        return result
    }

    public static func exp(_ base: Tensor, _ result: Tensor? = nil) -> Tensor {
        let result = result ?? Tensor(shape: base.shape)
        Executor.exec(ExpOp(base, result))
        return result
    }

    public static func set(_ base: Tensor, _ scalar: Float, _ result: Tensor? = nil) -> Tensor {
        let result = result ?? Tensor(shape: base.shape)
        _ = Tensor(scalar: scalar)
        Executor.exec(SetOp(base, result))
        return result
    }

    public static func abs(_ base: Tensor, _ result: Tensor? = nil) -> Tensor {
        let result = result ?? Tensor(shape: base.shape)
        Executor.exec(AbsOp(base, result))
        return result
    }

    public static func sin(_ base: Tensor, _ result: Tensor? = nil) -> Tensor {
        let result = result ?? Tensor(shape: base.shape)
        Executor.exec(SinOp(base, result))
        return result
    }

    public static func cos(_ base: Tensor, _ result: Tensor? = nil) -> Tensor {
        let result = result ?? Tensor(shape: base.shape)
        Executor.exec(CosOp(base, result))
        return result
    }

    public static func square(_ base: Tensor, _ result: Tensor? = nil) -> Tensor {
        let result = result ?? Tensor(shape: base.shape)
        Executor.exec(SquareOp(base, result))
        return result
    }

    public static func matmul(_ left: Tensor, _ right: Tensor, _ transposeLeft: Bool = false, _ transposeRight: Bool = false, result: Tensor? = nil) -> Tensor {

        let shape = [left.shape[0], right.shape[1]]
        let result = result ?? Tensor(shape: shape)

        let op = MatMulOp(left, right, result)
        Executor.exec(op)
        return result
    }

    public static func reduceSum(_ base: Tensor, _ dimension: Int = -1) -> Tensor {
        var shape = base.shape
        if (dimension == -1) {
            for i in 0..<shape.count {
                shape[i] = 1
            }
        } else {
            shape[dimension] = 1
        }
        
        let result = Tensor(shape: shape)
        let op = ReduceSumOp(base, base, result)
        Executor.exec(op)
        return result
    }

    public static func reduceSum(_ base: Tensor, _ dimensions: [Int]) -> Tensor {
//        var shape = base.shape
//        if (dim == -1) {
//            for i in 0..<shape.count {
//                shape[i] = 1
//            }
//        } else {
//            shape[dim] = 1
//        }
//
//        let result = Tensor(shape: shape)
//        let op = SumOp(base, base, result)
//        return Executor.instance.execAtDim(op, dim)
        return base
    }

    public static func reshape(_ base: Tensor, _ shape: [Int]) -> Tensor {
        if (ShapeUtils.shapeEquals(base.shape, shape)) {
            return base
        }

        return Tensor(data: base.data, shape: shape)
    }

    public static func negate(_ base: Tensor, _ result: Tensor? = nil) -> Tensor {
        let result = result ?? Tensor(shape: base.shape)
        let op = NegateOp(base, result)
        Executor.exec(op)
        return result
    }
}
