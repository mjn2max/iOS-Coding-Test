//
// IPViewModelsTests.swift
// 
//
// Created by Huy D. on 12/3/23
// mjn2max.github.io 😜
// 
// Copyright © 2023. All rights reserved.
// ___ORGANIZATIONNAME___
//

import XCTest
@testable import IPFramework

final class IPViewModelsTests: XCTestCase {
    var sut: IPViewModel!

    override func setUp() {
        super.setUp()
        sut = IPViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testIdle() {
        XCTAssertEqual(sut.pageState, .idle)
    }
    
    func testLoading() {
        XCTAssertEqual(sut.pageState, .idle)
    }
    
    func testFailed() {
        let service = MockFailedService()
        sut = IPViewModel(service: service)
        sut.fetchingData()
        XCTAssertEqual(sut.pageState, .failed)
    }
    
    func testSuccess() {
        let service = MockSuccessService()
        sut = IPViewModel(service: service)
        sut.fetchingData()
        XCTAssertEqual(sut.pageState, .success)
    }
}
