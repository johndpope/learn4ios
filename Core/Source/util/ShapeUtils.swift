//
//  ShapeUtils.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation

public class ShapeUtils {

    public static func broadcastShapes(_ a: [Int], _ b: [Int]) -> [Int] {
        let rank = a.count > b.count ? a.count : b.count
        var result = a.count > b.count ? a : b
        var aIndex = a.count - 1
        var bIndex = b.count - 1

        for _ in 0..<rank {
            if (aIndex < 0 || bIndex < 0) {
                break
            }

            let left = a[aIndex]
            let right = b[bIndex]

            if (left != 1 && right != 1 && left != right) {
                precondition(false, "cannot broadcast shapes. not compatible")
            }

            if (a.count > b.count) {
                result[aIndex] = max(left, right)
            } else {
                result[bIndex] = max(left, right)
            }

            aIndex -= 1
            bIndex -= 1
        }

        return result;
    }

    public static func getStrides(_ shape: [Int]) -> [Int] {
        let rank = shape.count
        var strides = shape
        var val = 1

        for i in (0..<rank).reversed() {
            strides[i] = val
            val *= shape[i]
        }

        return strides
    }

    public static func getLength(_ shape: [Int]) -> Int {
        var len = 1
        for dim in shape {
            len *= dim
        }
        return len
    }

    public static func reduce(_ shape: [Int], _ dimension: Int) -> [Int] {
        var result = shape // copy

        for i in 0..<shape.count {
            if (i == dimension || dimension == -1) {
                result[i] = 1
            }
        }

        return result
    }

    public static func getReducedDims(_ shape: [Int], _ dim: Int) -> [Bool] {
        if (dim == -1) {
            return Array(repeating: true, count: shape.count)
        }

        var reducedDims: [Bool] = Array(repeating: false, count: shape.count)
        reducedDims[dim] = true
        return reducedDims;
    }

    public static func getReducedDims(_ shape: [Int], _ dims: [Int]) -> [Bool] {
        var reducedDims: [Bool] = Array(repeating: false, count: shape.count)
        for dim in dims {
            reducedDims[dim] = true
        }
        return reducedDims;
    }

    public static func reduceShape(_ shape: [Int], _ dim: Int = -1, keepDims: Bool = false) -> [Int] {
        var resultShape: [Int] = []
        let reducedDims = ShapeUtils.getReducedDims(shape, dim)

        for i in 0..<shape.count {
            if (!reducedDims[i]) {
                resultShape.append(shape[i])
            } else if (keepDims) {
                resultShape.append(1)
            }
        }

        return resultShape;
    }

    public static func reduceShape(_ shape: [Int], _ dims: [Int], keepDims: Bool = false) -> [Int] {
        var resultShape: [Int] = []
        let reducedDims = ShapeUtils.getReducedDims(shape, dims)

        for i in 0..<shape.count {
            if (!reducedDims[i]) {
                resultShape.append(shape[i])
            } else if (keepDims) {
                resultShape.append(1)
            }
        }

        return resultShape;
    }

    public static func shapeEquals(_ a: [Int], _ b: [Int]) -> Bool {
        if (a.count != b.count) {
            return false;
        }

        for i in 0..<a.count {
            if (a[i] != b[i]) {
                return false;
            }
        }

        return true;
    }

    public static func shapeIsCompatible(_ a: [Int], _ b: [Int]) -> Bool {
        let rank = max(a.count, b.count)
        var aIndex = a.count - 1
        var bIndex = b.count - 1

        for _ in 0..<rank {
            if (aIndex < 0 || bIndex < 0) {
                break
            }
            let left = a[aIndex]
            let right = b[bIndex]
            aIndex -= 1
            bIndex -= 1
            if (left != 1 && right != 1 && left != right) {
                return false;
            }
        }

        return true;
    }

    public static func getReductionIndices(_ a: [Int], _ b: [Int]) -> (left: [Int], right: [Int]) {
        let resultShape = ShapeUtils.broadcastShapes(a, b)
        var left: [Int] = []
        var right: [Int] = []
        for i in 0..<a.count {
            if (a[i] == 1 && a[i] != resultShape[i]) {
                left.append(i)
            }

            if (b[i] == 1 && b[i] != resultShape[i]) {
                right.append(i)
            }
        }

        return (
            left: left.count > 0 ? left : [],
            right: right.count > 0 ? right : []
        )
    }
}
