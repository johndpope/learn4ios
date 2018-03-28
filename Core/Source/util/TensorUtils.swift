//
//  TensorUtils.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 25/02/2018.
//

import Foundation

public class TensorUtils {

    public static func computeOffset(_ indices: [Int], _ shape: [Int], _ strides: [Int]) -> Int {
        var offset = 0;
        for i in 0..<shape.count {
            offset += indices[i] * strides[i]
        }
        return offset;
    }

    public static func broadcast(_ tensor: Tensor, _ shape: [Int]) -> Tensor {

        if (ShapeUtils.shapeEquals(tensor.shape, shape)) {
            return tensor
        }

        let compatible = ShapeUtils.shapeIsCompatible(tensor.shape, shape)

        if (!compatible) {
            assert(false, "Incompatible broadcast from \(tensor.shape) to \(shape)")
            return tensor
        }

        let retShape = ShapeUtils.broadcastShapes(tensor.shape, shape)
        var result = Tensor(shape: retShape)
        var broadcastDims: [Int] = []

        // pad front
        let front = retShape.count - tensor.shape.count
        for i in 0..<retShape.count {
            if (i < front || (tensor.shape[i - front] == 1 && retShape[i] != 1)) {
                broadcastDims.append(1)
            } else {
                broadcastDims.append(0)
            }
        }

        let indices = Array(repeating: 0, count: retShape.count)
        broadcastAtDim(tensor, &result, 0, front, broadcastDims, retShape, indices)

        return result
    }

    private static func broadcastAtDim(_ tensor: Tensor, _ result: inout Tensor, _ dim: Int, _ front: Int, _ broadcastDims: [Int], _ retShape: [Int], _ targetIndices: [Int]) {

        if (dim == targetIndices.count) {
            var sourceIndices: [Int] = []
            for i in front..<targetIndices.count {
                if (broadcastDims[i] == 1) {
                    sourceIndices.append(0)
                } else {
                    sourceIndices.append(targetIndices[i])
                }
            }

            let sourceOffset = computeOffset(sourceIndices, tensor.shape, tensor.strides)
            let targetOffset = computeOffset(targetIndices, result.shape, result.strides)

            result.data[targetOffset] = tensor.data[sourceOffset];
            return
        }

        for i in 0..<retShape[dim] {
            var newIndices = targetIndices
            newIndices[dim] = i;
            broadcastAtDim(tensor, &result, dim + 1, front, broadcastDims, retShape, newIndices)
        }
    }
    
}
