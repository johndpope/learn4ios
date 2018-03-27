//
//  TensorFormatter.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 25/02/2018.
//

import Foundation

class TensorFormatter {

    static var instance: TensorFormatter = TensorFormatter()

    var separator: String = "  "
    var padding: Int = 0
    var decimalFormat: Any? = nil
    var precision: Int = 8

    func format(_ tensor: Tensor) -> String {
        return format(tensor, tensor.rank)
    }

    private func format(_ tensor: Tensor, _ rank: Int, _ indent: Int = 0) -> String {
        if (tensor.isScalar) {
            return formatNumber(tensor[0]);
        }

        if (tensor.isVector) {
            var result = "["
            for i in 0..<tensor.length {
                result += formatNumber(tensor[i])
                if (i < tensor.length - 1) {
                    result += separator
                }
            }
            result += "]"
            return result
        }

        var result = "["
        for i in 0..<tensor.slices {
            let slice = tensor.slice(i)
            result += format(slice, rank - 1, indent + 1)

            if (i != tensor.slices - 1) {
                result += separator + "\n"
                result += String(repeating: "\n", count: rank - 2)
                result += String(repeating: " ", count: indent + 1)
            }
        }
        result += "]"
        return result
    }

    private func formatNumber(_ number: Float) -> String {
        return number.description
    }
}
