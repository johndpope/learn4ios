//
//  Learn4iOSTests.swift
//  Learn4iOSTests
//
//  Created by Luan Guangmiao on 27/03/2018.
//  Copyright © 2018 Guangmiao Luan. All rights reserved.
//

import XCTest
@testable import Learn4iOS

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let a = Tensor(data: [1,2,3], shape: [3])
        let b = Tensor(data: [1, 2], shape: [2, 1])
        let c = a + b
        
        print(c)
        
        let l = parameter(a)
        let m = parameter(b)
        let k = l + m
        
        print(k.value)

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
