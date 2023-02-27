//
//  FilterProgressiveMediaFilesTests.swift
//  VmaxNGTests
//
//  Created by Cloy Monis on 02/07/21.
//

// swiftlint: disable all
import XCTest
@testable import Vmax
@testable import VmaxVastHelper

class FilterProgressiveMediaFilesTests: XCTestCase {
    
    var sut: FilterProgressiveMediaFiles?
    
    override func setUpWithError() throws {
        sut = FilterProgressiveMediaFiles()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_filterProgress() {
        let noOfMedia = 3
        let media1 = VmaxMediaFile(bitrate: 1, dict: [VmaxVastParserAttributes.delivery.rawValue:"progressive"])
        XCTAssertTrue(validateCount(mediaFiles: [media1,media1,media1], expectedCount: noOfMedia))
    }
    
    func test_filterEmptyDelivery() {
        let noOfMedia = 0
        let media1 = VmaxMediaFile(bitrate: 1)
        XCTAssertTrue(validateCount(mediaFiles: [media1,media1,media1], expectedCount: noOfMedia))
    }
    
    func test_filterProgressButPassingStreamData() {
        let noOfMedia = 3
        let media1 = VmaxMediaFile(bitrate: 1, dict: [VmaxVastParserAttributes.delivery.rawValue:"streaming"])
        XCTAssertFalse(validateCount(mediaFiles: [media1,media1,media1], expectedCount: noOfMedia))
    }
    
    func test_filterProgreesWithStreamData() {
        let noOfMedia = 2
        let media1 = VmaxMediaFile(bitrate: 1, dict: [VmaxVastParserAttributes.delivery.rawValue:"progressive"])
        let media2 = VmaxMediaFile(bitrate: 3, dict: [VmaxVastParserAttributes.delivery.rawValue:"streaming"])
        XCTAssertTrue(validateCount(mediaFiles: [media1,media1,media2,media2,media2], expectedCount: noOfMedia))
    }
}

extension FilterProgressiveMediaFilesTests {
    func validateCount(mediaFiles: [VmaxMediaFile], expectedCount: Int) -> Bool {
        guard let sut = sut else {
            XCTFail("failed")
            return false
        }
        let filteredFiles = sut.get(mediaFiles: mediaFiles)
        return filteredFiles.count == expectedCount ? true : false
    }
}
