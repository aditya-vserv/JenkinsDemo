//
//  JenkinsFrameworkTests.swift
//  JenkinsFrameworkTests
//
//  Created by Admin_Vserv on 23/02/23.
//

import XCTest
@testable import JenkinsFramework

class JenkinsFrameworkTests: XCTestCase {
    let sut = JenkinsFramework.shared
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testHappyPath() throws {
        let value1 = 5
        let value2 = 3
        XCTAssertTrue(sut.add(a1: value1, a2: value2) == 8)
        XCTAssertTrue(sut.sub(a1: value1, a2: value2) == 2)
        XCTAssertTrue(sut.multiply(a1: value1, a2: value2) == 15)
    }
    /*
    func testFailure() throws {
        let value1 = 5
        let value2 = 3
        XCTAssertTrue(sut.add(a1: value1, a2: value2) == value1)
    }
    */
}
