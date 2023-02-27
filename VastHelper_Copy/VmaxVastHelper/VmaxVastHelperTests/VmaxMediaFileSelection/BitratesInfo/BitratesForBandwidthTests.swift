//
//  BitratesForBandwidthTests.swift
//  VmaxNGTests
//
//  Created by Cloy Monis on 02/07/21.
//

// swiftlint: disable all
import XCTest
@testable import Vmax
@testable import VmaxVastHelper

class BitratesForBandwidthTests: XCTestCase {
    var sut: BitratesForBandwidth!
    override func setUpWithError() throws {
        sut = BitratesForBandwidth(m2G: 128, m3G: 160, m4G: 500, m5G: 1200, ethernetOrWifi: 640)
    }
    override func tearDownWithError() throws {
        sut = nil
    }
    func test_EquatableProtocol() {
        let sutToTestAgainst = BitratesForBandwidth(m2G: 128, m3G: 160, m4G: 500, m5G: 1200, ethernetOrWifi: 640)
        XCTAssertTrue(sut == sutToTestAgainst)
    }
    func test_BitratesResponse() {
        for connectionType in ConnectionType.allCases {
            switch connectionType {
            case .cellularNetwork2G:
                self.permutationSuccess(connectionType: connectionType, bitrateExpected: 128)
            case .unknown:
                self.permutationFailed(connectionType: connectionType)
            case .ethernet:
                self.permutationSuccess(connectionType: connectionType, bitrateExpected: 640)
            case .wifi:
                self.permutationSuccess(connectionType: connectionType, bitrateExpected: 640)
            case .cellularNetworkUnkownGeneration:
                self.permutationFailed(connectionType: connectionType)
            case .cellularNetwork3G:
                self.permutationSuccess(connectionType: connectionType, bitrateExpected: 160)
            case .cellularNetwork4G:
                self.permutationSuccess(connectionType: connectionType, bitrateExpected: 500)
            case .cellularNetwork5G:
                self.permutationSuccess(connectionType: connectionType, bitrateExpected: 1200)
            }
        }
    }
}

extension BitratesForBandwidthTests {
    func permutationSuccess(connectionType: ConnectionType, bitrateExpected: Int) {
        let bitrateResponse = sut.getBitrate(connectionType: connectionType)
        XCTAssertTrue(bitrateResponse == bitrateExpected)
    }
    func permutationFailed(connectionType: ConnectionType) {
        let response = sut.getBitrate(connectionType: connectionType)
        XCTAssertNil(response)
    }
}
