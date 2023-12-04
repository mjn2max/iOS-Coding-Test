//
// IPServiceTests.swift
// 
//
// Created by Huy D. on 12/3/23
// mjn2max.github.io 😜
// 
// Copyright © 2023. All rights reserved.
// ___ORGANIZATIONNAME___
//

import XCTest
import Combine
@testable import IPFramework

final class IPServiceTests: XCTestCase {
    var sut: IPService!

    override func setUp() {
        super.setUp()
        sut = IPService()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testApiCall() {
        let exp = expectation(description: "testApiCall")
        var cancellable: AnyCancellable?
        cancellable = sut.getIPData()
            .sink(receiveCompletion: { completion in
                cancellable?.cancel()
                exp.fulfill()
            }, receiveValue: { value in
                XCTAssertNotNil(value)
            })
        
        waitForExpectations(timeout: 10)
    }
}
