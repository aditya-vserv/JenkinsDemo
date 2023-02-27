//
//  BitrateAllocationTests.swift
//  VmaxNGTests
//
//  Created by Cloy Monis on 02/07/21.
//

// swiftlint: disable all
import XCTest
@testable import VmaxVastHelper

class BitrateAllocationTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    func test_IsEquatable() {
        let lhs = BitratesForBandwidth(m2G: 64, m3G: 128, m4G: 500, m5G: 1200, ethernetOrWifi: 640)
        let rhs = BitratesForBandwidth(m2G: 64, m3G: 128, m4G: 500, m5G: 1200, ethernetOrWifi: 640)
        XCTAssertTrue(lhs == rhs)
    }
}
