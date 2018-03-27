//
//  Executor.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 23/02/2018.
//

import Foundation

/// Executor class manages execution of operations
/// At this time, use exec to immediately execute
/// At future, implement async exec with queue
class Executor {

    /// Immediate execution of the op
    static func exec(_ op: Operation) {
        if (op.isSpecial) {
            op.exec()
            return
        }

        if let pairwiseOp = op as? PairwiseOp {
            PairwiseExecutor.exec(pairwiseOp)
        }
    }

    // TODO: func async(_ op: Operation) -> Async
}
