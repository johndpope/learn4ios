//
//  PairwiseExecutor.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 27/03/2018.
//

import Foundation

class PairwiseExecutor {

    static func exec(_ op: PairwiseOp) {
        switch op.result.rank {
        case 0:
            execScalar(op)
        case 1:
            execVector(op)
        case 2:
            execMatrix(op)
        default:
            execGeneral(op)
        }
    }

    private static func execScalar(_ op: PairwiseOp) {
        op.result[0] = op.body(op.input[0], op.other[0])
    }

    private static func execVector(_ op: PairwiseOp) {
        let result = op.result
        let shape = result.shape
        let rank = result.rank
        let input = op.input.reshape(toRank: rank)
        let other = op.other.reshape(toRank: rank)

        let inputS0 = input.shape[0] == 1 ? 0 : input.strides[0]
        let otherS0 = other.shape[0] == 1 ? 0 : other.strides[0]
        let resultS0 = result.strides[0]
        let s0 = shape[0]

        var iPtr = 0
        var oPtr = 0
        var rPtr = 0

        for _ in 0..<s0 {
            result[rPtr] = op.body(input[iPtr], other[oPtr])
            iPtr += inputS0
            oPtr += otherS0
            rPtr += resultS0
        }
    }

    private static func execMatrix(_ op: PairwiseOp) {
        let result = op.result
        let shape = result.shape
        let rank = result.rank
        let input = op.input.reshape(toRank: rank)
        let other = op.other.reshape(toRank: rank)

        let inputS0 = input.shape[0] == 1 ? 0 : input.strides[0]
        let inputS1 = input.shape[1] == 1 ? 0 : input.strides[1]
        let otherS0 = other.shape[0] == 1 ? 0 : other.strides[0]
        let otherS1 = other.shape[1] == 1 ? 0 : other.strides[1]
        let resultS0 = result.strides[0]
        let resultS1 = result.strides[1]
        let s0 = shape[0]
        let s1 = shape[1]

        var iPtr = 0
        var oPtr = 0
        var rPtr = 0

        let inputD0 = inputS0 - inputS1 * s1
        let otherD0 = otherS0 - otherS1 * s1
        let resultD0 = resultS0 - resultS1 * s1

        let inputD1 = inputS1
        let otherD1 = otherS1
        let resultD1 = resultS1

        for _ in 0..<s0 {
            for _ in 0..<s1 {
                result[rPtr] = op.body(input[iPtr], other[oPtr])
                iPtr += inputD1
                oPtr += otherD1
                rPtr += resultD1
            }

            iPtr += inputD0
            oPtr += otherD0
            rPtr += resultD0
        }
    }

    private static func execGeneral(_ op: PairwiseOp) {
        let result = op.result
        let shape = result.shape
        let rank = result.rank
        let input = op.input.reshape(toRank: rank)
        let other = op.other.reshape(toRank: rank)

        var MEM: [Int] = []
        var iS = Array<Int>(repeating: 0, count: rank)
        var oS = Array<Int>(repeating: 0, count: rank)
        var rS = Array<Int>(repeating: 0, count: rank)

        for i in 0..<rank {
            let r = rank - 1 - i
            MEM.append(shape[r])
            iS[i] = input.shape[r] == 1 ? 0 : input.strides[r]
            oS[i] = other.shape[r] == 1 ? 0 : other.strides[r]
            rS[i] = result.strides[r]
            MEM.append(iS[i] - (i > 0 ? iS[i - 1] * shape[rank - i] : 0))
            MEM.append(oS[i] - (i > 0 ? oS[i - 1] * shape[rank - i] : 0))
            MEM.append(rS[i] - (i > 0 ? rS[i - 1] * shape[rank - i] : 0))
        }

        var inputPointer = 0
        var otherPointer = 0
        var resultPointer = 0

        var index = 0;
        var ptr = 0;
        for _ in 0..<result.length {
            ptr = rank
            index = 0
            MEM[0] = MEM[0] + 1

            result[resultPointer] = op.body(input[inputPointer], other[otherPointer])
            inputPointer += MEM[ptr + 1]
            otherPointer += MEM[ptr + 2]
            resultPointer += MEM[ptr + 3]

            while (MEM[index] == MEM[ptr] && index < rank - 1) {
                MEM[index] = 0
                index += 1
                MEM[index] += 1
                ptr += 4
                inputPointer += MEM[ptr + 1]
                otherPointer += MEM[ptr + 2]
                resultPointer += MEM[ptr + 3]
            }
        }
    }
}
