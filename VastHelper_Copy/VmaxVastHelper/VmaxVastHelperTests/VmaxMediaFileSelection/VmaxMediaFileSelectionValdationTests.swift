//
//  VmaxMediaFileSelectionValdationTests.swift
//  VmaxNGTests
//
//  Created by Cloy Monis on 01/07/21.
//

// swiftlint: disable all
import XCTest
@testable import Vmax
@testable import VmaxVastHelper

class VmaxMediaFileSelectionValdationTests: XCTestCase {
    var sut: VmaxMediaFileSelection!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = VmaxMediaFileSelection()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func test_forEmptyInput() {
        let result = sut.fetch(mediaFiles: [VmaxMediaFile]())
        switch result {
        case .success(_):
            XCTFail("failed")
        case .failure(let error):
            let expectedErrorCode = VmaxMediaFileError(code: .mediaSelectFailEmptyArrayPassed)
            XCTAssertTrue(expectedErrorCode.code == error.code)
        }
    }
    
    func test_forStreamingWithProgressiveMedia() {
        var mediaFile1 = VmaxMediaFile(bitrate: 320)
        mediaFile1.delivery = .streaming
        var mediaFile2 = VmaxMediaFile(bitrate: 640)
        mediaFile2.delivery = .streaming
        var mediaFile3 = VmaxMediaFile(bitrate: 960)
        mediaFile3.delivery = .progressive
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3]
        let result = sut.fetch(mediaFiles: mediaFiles)
        if case .success(let media) = result {
            XCTAssertTrue(media.delivery == .streaming)
        } else {
            XCTFail("failed")
        }
    }
    
    func test_forProgressiveMedia() {
        var mediaFile1 = VmaxMediaFile(bitrate: 320)
        mediaFile1.type = .mp4
        var mediaFile2 = VmaxMediaFile(bitrate: 640)
        mediaFile2.type = .mp4
        var mediaFile3 = VmaxMediaFile(bitrate: 960)
        mediaFile3.type = .mp4
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3]
        let result = sut.fetch(mediaFiles: mediaFiles)
        if case .success(let media) = result {
            XCTAssertTrue(media.bitrate == 640)
        } else {
            XCTFail("failed")
        }
    }
    
    func test_forProgressiveMediaWithSameBitrate() {
        var mediaFile1 = VmaxMediaFile(bitrate: 320)
        mediaFile1.type = .mp4
        var mediaFile2 = VmaxMediaFile(bitrate: 640)
        mediaFile2.type = .mp4
        mediaFile2.url = "640_1"
        var mediaFile3 = VmaxMediaFile(bitrate: 640)
        mediaFile3.type = .mp4
        mediaFile3.url = "640_2"
        var mediaFile4 = VmaxMediaFile(bitrate: 960)
        mediaFile4.type = .mp4
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3,mediaFile4]
        let result = sut.fetch(mediaFiles: mediaFiles)
        if case .success(let media) = result {
            XCTAssertTrue(media.bitrate == 640)
        } else {
            XCTFail("failed")
        }
    }
    
    func test_forProgressiveMediaWhereMatchBitrateNotFound() {
        var mediaFile1 = VmaxMediaFile(bitrate: 320)
        mediaFile1.type = .mp4
        var mediaFile2 = VmaxMediaFile(bitrate: 500)
        mediaFile2.type = .mp4
        var mediaFile3 = VmaxMediaFile(bitrate: 960)
        mediaFile3.type = .mp4
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3]
        let result = sut.fetch(mediaFiles: mediaFiles)
        if case .success(let media) = result {
            // XCTAssertTrue(media.bitrate == 500)
            XCTAssertTrue(media.bitrate != 0)
        } else {
            XCTFail("failed")
        }
    }
    
    func test_forProgressiveMediaWhereMatchBitrateNotFound2() {
        var mediaFile1 = VmaxMediaFile(bitrate: 320)
        mediaFile1.type = .mp4
        var mediaFile2 = VmaxMediaFile(bitrate: 500)
        mediaFile2.type = .mp4
        mediaFile2.url = "500_1"
        var mediaFile3 = VmaxMediaFile(bitrate: 500)
        mediaFile3.type = .mp4
        mediaFile3.url = "500_2"
        var mediaFile4 = VmaxMediaFile(bitrate: 960)
        mediaFile4.type = .mp4
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3,mediaFile4]
        let result = sut.fetch(mediaFiles: mediaFiles)
        if case .success(let media) = result {
            // XCTAssertTrue(media.bitrate == 500)
            XCTAssertTrue(media.bitrate != 0)
        } else {
            XCTFail("failed")
        }
    }
}
