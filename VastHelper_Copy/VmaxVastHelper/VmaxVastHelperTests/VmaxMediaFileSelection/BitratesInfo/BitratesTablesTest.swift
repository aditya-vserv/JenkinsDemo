//
//  BitratesTablesTest.swift
//  VmaxNGTests
//
//  Created by Cloy Monis on 02/07/21.
//

// swiftlint: disable all
import XCTest
@testable import Vmax
@testable import VmaxVastHelper

class BitratesTablesTest: XCTestCase {
    var sut: BitratesTables!
    var phone: BitratesForBandwidth!
    var pad: BitratesForBandwidth!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = BitratesTables()
        phone = self.get(deviceType: .phone)
        pad = self.get(deviceType: .tablet)
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        phone = nil
        pad = nil
    }
    /*
    func test_init() {
        XCTAssertTrue(sut.phone == phone)
        XCTAssertTrue(sut.pad == pad)
    }
    */
    func test_PhoneAllPermutation() {
        // self.phone = BitratesForBandwidth(_2G: 64, _3G: 128, _4G: 500, _5G: 1200, _EthernetOrWifi: 640)
        let deviceType = DeviceType.phone
        for connectionType in ConnectionType.allCases {
            switch connectionType {
            case .cellularNetwork2G:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 64)
            case .unknown:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            case .ethernet:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 640)
            case .wifi:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 640)
            case .cellularNetworkUnkownGeneration:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            case .cellularNetwork3G:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 128)
            case .cellularNetwork4G:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 500)
            case .cellularNetwork5G:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 1200)
            }
        }
    }
    func test_PadAllPermutation() {
        // self.pad = BitratesForBandwidth(_2G: 128, _3G: 160, _4G: 500, _5G: 1200, _EthernetOrWifi: 640)
        let deviceType = DeviceType.tablet
        for connectionType in ConnectionType.allCases {
            switch connectionType {
            case .cellularNetwork2G:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 128)
            case .unknown:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            case .ethernet:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 640)
            case .wifi:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 640)
            case .cellularNetworkUnkownGeneration:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            case .cellularNetwork3G:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 160)
            case .cellularNetwork4G:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 500)
            case .cellularNetwork5G:
                self.permutationSuccess(deviceType: deviceType, connectionType: connectionType, bitrateExpected: 1200)
            }
        }
    }
    func test_UnregisrteredDevicePermutation_MobileTablet() {
        let deviceType = DeviceType.mobileTablet
        permutation(deviceType: deviceType)
    }
    func test_UnregisrteredDevicePermutation_PC() {
        let deviceType = DeviceType.personalComputer
        permutation(deviceType: deviceType)
    }
    func test_UnregisrteredDevicePermutation_TV() {
        let deviceType = DeviceType.connectedTV
        permutation(deviceType: deviceType)
    }
    func test_UnregisrteredDevicePermutation_ConnectedDevice() {
        let deviceType = DeviceType.connectedDevice
        permutation(deviceType: deviceType)
    }
    func test_UnregisrteredDevicePermutation_SetupBox() {
        let deviceType = DeviceType.setupBox
        permutation(deviceType: deviceType)
    }
}

extension BitratesTablesTest {
    func get(deviceType: DeviceType) -> BitratesForBandwidth? {
        guard deviceType == .phone || deviceType == .tablet else {
            return nil
        }
        let testBundle = Bundle(for: BitratesTablesTest.self)
        guard let url = testBundle.url(forResource: "BitrateAllocations", withExtension: ".plist"),
              let arr = NSArray(contentsOf: url) else {
            return nil
        }
        var bit: BitratesForBandwidth?
        for eachDict in arr {
            if let attributeDict = eachDict as? NSDictionary,
               let device = attributeDict["device"] as? String,
               device == deviceType.stringValue {
                if let IIGen = attributeDict["2G"] as? Int,
                   let IIIGen = attributeDict["3G"] as? Int,
                   let IVGen = attributeDict["4G"] as? Int,
                   let VGen = attributeDict["5G"] as? Int,
                   let wifi = attributeDict["Wifi"] as? Int {
                    bit = BitratesForBandwidth(m2G: IIGen, m3G: IIIGen, m4G: IVGen, m5G: VGen, ethernetOrWifi: wifi)
                }
            }
        }
        return bit
    }
    func permutation(deviceType: DeviceType) {
        for connectionType in ConnectionType.allCases {
            switch connectionType {
            case .cellularNetwork2G:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            case .unknown:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            case .ethernet:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            case .wifi:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            case .cellularNetworkUnkownGeneration:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            case .cellularNetwork3G:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            case .cellularNetwork4G:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            case .cellularNetwork5G:
                self.permutationFail(deviceType: deviceType, connectionType: connectionType)
            }
        }
    }
    func permutationSuccess(deviceType: DeviceType, connectionType: ConnectionType, bitrateExpected: Int) {
        let result = sut.getBitrate(deviceType: deviceType, connectionType: connectionType)
        switch result {
        case .success(let val):
            XCTAssertTrue(val == bitrateExpected)
        default:
            XCTFail("failed")
        }
    }
    func permutationFail(deviceType: DeviceType, connectionType: ConnectionType) {
        let errorExpected = VmaxMediaFileError(code: .mediaSelectFailUnkownBitrate)
        let result = sut.getBitrate(deviceType: deviceType, connectionType: connectionType)
        switch result {
        case .success(_):
            XCTFail("failed")
        case .failure(let error):
            XCTAssertTrue(errorExpected.code == error.code)
        }
    }
}
