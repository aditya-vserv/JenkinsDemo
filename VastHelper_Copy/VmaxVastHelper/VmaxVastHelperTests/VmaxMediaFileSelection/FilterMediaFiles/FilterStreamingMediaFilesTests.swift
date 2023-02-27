//
//  FilterStreamingMediaFilesTests.swift
//  VmaxVastHelperTests
//
//  Created by Admin_Vserv on 09/02/23.
//

// swiftlint: disable all
import XCTest
@testable import Vmax
@testable import VmaxVastHelper

class FilterStreamingMediaFilesTests: XCTestCase {
    
    var sut: FilterStreamingMediaFiles?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FilterStreamingMediaFiles()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_filterStreaming() {
        let noOfMedia = 3
        let media1 = VmaxMediaFile(bitrate: 1, dict: [VmaxVastParserAttributes.delivery.rawValue:"streaming"])
        XCTAssertTrue(validateCount(mediaFiles: [media1,media1,media1], expectedCount: noOfMedia))
    }
    
    func test_filterStreamingWithProgressiveData() {
        let noOfMedia = 3
        let media1 = VmaxMediaFile(bitrate: 1, dict: [VmaxVastParserAttributes.delivery.rawValue:"progressive"])
        let media2 = VmaxMediaFile(bitrate: 3, dict: [VmaxVastParserAttributes.delivery.rawValue:"streaming"])
        XCTAssertTrue(validateCount(mediaFiles: [media1,media2,media1,media2,media2], expectedCount: noOfMedia))
    }
}

extension FilterStreamingMediaFilesTests {
    func validateCount(mediaFiles: [VmaxMediaFile], expectedCount: Int) -> Bool {
        guard let sut = sut else {
            XCTFail("failed")
            return false
        }
        let filteredFiles = sut.get(mediaFiles: mediaFiles)
        return filteredFiles.count == expectedCount ? true : false
    }
}
