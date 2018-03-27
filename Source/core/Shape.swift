//
//  Shape.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 21/02/2018.
//

import Foundation

class Shape {

    var shape: [Int]

    var strides: [Int]

    var length: Int

    var rank: Int {
        return shape.count
    }

    var order: Character

    init(_ shape: [Int], _ strides: [Int] = [], _ order: Character = "c") {
        self.shape = shape
        self.strides = strides
        if (strides.count == 0) {
            self.strides = ShapeUtils.getStrides(shape)
        }
        self.length = ShapeUtils.getLength(shape)
        self.order = order
    }

    func getOffset(_ indices: [Int]) -> Int {
        var offset = 0
        for i in 0..<rank {
            offset += indices[i] * strides[i]
        }
        return offset;
    }
}
