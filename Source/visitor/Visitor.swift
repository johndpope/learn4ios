//
//  Visitor.swift
//  learn4ios
//
//  Created by Luan Guangmiao on 20/02/2018.
//

import Foundation

public protocol Visitor {

    func visit(_ node: Expression, _ params: Any?)
    
}
