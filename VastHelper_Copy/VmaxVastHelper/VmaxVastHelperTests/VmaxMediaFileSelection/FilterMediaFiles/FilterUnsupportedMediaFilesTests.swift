//
//  FilterUnsupportedMediaFilesTests.swift
//  VmaxNGTests
//
//  Created by Cloy Monis on 02/07/21.
//

// swiftlint: disable all
import XCTest
@testable import Vmax
@testable import VmaxVastHelper

class FilterUnsupportedMediaFilesTests: XCTestCase {
    
    var sut: FilterSupportedMediaFiles?
    
    override func setUpWithError() throws {
        sut = FilterSupportedMediaFiles()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_HappyPath() {
        var mediaFile1 = VmaxMediaFile(bitrate: 320)
        mediaFile1.type = .mp4
        var mediaFile2 = VmaxMediaFile(bitrate: 640)
        mediaFile2.type = .mp4
        var mediaFile3 = VmaxMediaFile(bitrate: 960)
        mediaFile3.type = .mp4
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3]
        self.validateCount(mediaFiles: mediaFiles, expectedCount: 3)
    }
}

extension FilterUnsupportedMediaFilesTests {
    func validateCount(mediaFiles: [VmaxMediaFile], expectedCount: Int) {
        guard let sut = sut else {
            XCTFail("failed")
            return
        }
        let filteredFiles = sut.get(mediaFiles: mediaFiles)
        XCTAssertTrue( filteredFiles.count == expectedCount )
    }
}
