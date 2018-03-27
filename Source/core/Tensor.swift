//
//  Tensor.swift
//  learn4ios
//
//  Created by Guangmiao Luan on 20/02/2018.
//

import Foundation

public class Tensor: CustomStringConvertible {

    public var data: [Float]

    private var _shape: Shape
    public var shape: [Int] {
        return _shape.shape
    }

    public var offset: Int = 0

    public var strides: [Int] {
        return _shape.strides
    }

    public var slices: Int {
        return rank > 0 ? shape[0]: 0
    }

    public var rank: Int {
        return _shape.rank
    }

    public var length: Int {
        return _shape.length
    }

    public var isScalar: Bool {
        return rank == 0
    }

    public var isVector: Bool {
        return rank == 1
    }

    public var isMatrix: Bool {
        return rank == 2
    }

    public var description: String {
        return TensorFormatter.instance.format(self)
    }

    public subscript(_ offset: Int) -> Float {
        get {
            return data[offset + self.offset]
        }
        set {
            data[offset + self.offset] = newValue
        }
    }

    public subscript(_ indices: [Int]) -> Float {
        get {
            let offset = _shape.getOffset(indices) + self.offset
            return data[offset]
        }
        set {
            let offset = _shape.getOffset(indices) + self.offset
            data[offset] = newValue
        }
    }

    // Creates an empty Tensor with the shape
    public init(shape: [Int]) {
        _shape = Shape(shape)
        self.data = Array(repeating: 0, count: _shape.length)
    }

    // Create an Tensor with the data, shape and offset
    public init(data: [Float], shape: [Int], offset: Int = 0) {
        self.data = data
        self.offset = offset
        _shape = Shape(shape)
    }

    // Create a single Scalar tensor
    public init(scalar: Float) {
        data = [scalar]
        _shape = Shape([])
    }

    // Create a Tensor filled with scalar value
    public init(scalar: Float, shape: [Int]) {
        _shape = Shape(shape)
        self.data = Array(repeating: scalar, count: _shape.length)
    }

    init(data: [Float], shape: Shape, offset: Int) {
        self.data = data
        self.offset = offset
        _shape = shape
    }

    public func reshape(_ shape: [Int]) -> Tensor {
        return TensorMath.reshape(self, shape)
    }

    /// This method reshapes the tensor to the given rank (if rank is higher)
    public func reshape(toRank rank: Int) -> Tensor {
        let diff = rank - self.rank
        if (diff <= 0) {
            return self
        }

        var newShape = shape
        for _ in 0..<diff {
            newShape.insert(1, at: 0)
        }
        return TensorMath.reshape(self, newShape)
    }

    public func broadcast(_ shape: [Int]) -> Tensor {
        return TensorUtils.broadcast(self, shape)
    }

    public func slice(_ num: Int) -> Tensor {
        var newShape: [Int] = []
        var newStrides: [Int] = []

        let newOffset = offset + num * strides[0]

        for i in 1..<rank {
            newShape.append(shape[i])
            newStrides.append(strides[i])
        }

        let newShapeObj = Shape(newShape, newStrides)
        return Tensor(data: data, shape: newShapeObj, offset: newOffset)
    }

}
