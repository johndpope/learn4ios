//
//  Operation.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 21/02/2018.
//

import Foundation

public protocol Operation {

    // The primary input
    var input: Tensor { get }

    // The secondary input.
    var other: Tensor { get }

    // The result Tensor
    var result: Tensor { get }

    // Operation only need to specify if this is a special op.
    var isSpecial: Bool { get }

    // Operations should implement exec
    func exec()

}

