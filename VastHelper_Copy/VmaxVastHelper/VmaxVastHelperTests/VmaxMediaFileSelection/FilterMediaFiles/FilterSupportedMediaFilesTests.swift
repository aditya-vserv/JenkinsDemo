//
//  FilterSupportedMediaFilesTests.swift
//  VmaxNG_Tests
//
//  Created by Admin_Vserv on 27/05/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

// swiftlint: disable all
import XCTest
@testable import Vmax
@testable import VmaxVastHelper

class FilterSupportedMediaFilesTests: XCTestCase {
    
    var sut: FilterSupportedMediaFiles?
    
    override func setUpWithError() throws {
        sut = FilterSupportedMediaFiles()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_filterVideo() {
        let noOfMedia = 3
        let media1 = VmaxMediaFile(bitrate: 1, dict: [VmaxVastParserAttributes.type.rawValue:"video/mp4"])
        XCTAssertTrue(validateCount(mediaFiles: [media1,media1,media1], expectedCount: noOfMedia))
    }
    
    func test_filterVideoButPassingAudioData() {
        let noOfMedia = 3
        let media1 = VmaxMediaFile(bitrate: 1, dict: [VmaxVastParserAttributes.type.rawValue:"audio/mp3"])
        XCTAssertFalse(validateCount(mediaFiles: [media1,media1,media1], expectedCount: noOfMedia))
    }
    
    func test_filterVideoWithAudioData() {
        let noOfMedia = 2
        let media1 = VmaxMediaFile(bitrate: 1, dict: [VmaxVastParserAttributes.type.rawValue:"video/mp4"])
        let media2 = VmaxMediaFile(bitrate: 3, dict: [VmaxVastParserAttributes.type.rawValue:"audio/mp3"])
        XCTAssertTrue(validateCount(mediaFiles: [media1,media1,media2,media2,media2], expectedCount: noOfMedia))
    }
}

extension FilterSupportedMediaFilesTests {
    func validateCount(mediaFiles: [VmaxMediaFile], expectedCount: Int) -> Bool {
        guard let sut = sut else {
            XCTFail("failed")
            return false
        }
        let filteredFiles = sut.get(mediaFiles: mediaFiles)
        return filteredFiles.count == expectedCount ? true : false
    }
}
