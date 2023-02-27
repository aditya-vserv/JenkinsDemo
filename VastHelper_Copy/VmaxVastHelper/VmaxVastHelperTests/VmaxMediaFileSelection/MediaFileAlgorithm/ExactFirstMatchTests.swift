//
//  ExactFirstMatchTests.swift
//  VmaxNGTests
//
//  Created by Cloy Monis on 02/07/21.
//

// swiftlint: disable all
import XCTest
@testable import Vmax
@testable import VmaxVastHelper

class ExactFirstMatchTests: XCTestCase {
    var sut: ExactFirstMatch!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ExactFirstMatch()
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    func test_HappyPath() {
        let mediaFile1 = VmaxMediaFile(bitrate: 320)
        let mediaFile2 = VmaxMediaFile(bitrate: 640)
        let mediaFile3 = VmaxMediaFile(bitrate: 960)
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3]
        XCTAssertTrue(bitrateExist(mediaFiles: mediaFiles, bitrate: 640))
    }
    func test_RandomSelection() {
        var mediaFile1 = VmaxMediaFile(bitrate: 320)
        mediaFile1.url = "320_1.mp4"
        var mediaFile2 = VmaxMediaFile(bitrate: 320)
        mediaFile2.url = "320_2.mp4"
        let mediaFile3 = VmaxMediaFile(bitrate: 640)
        let mediaFile4 = VmaxMediaFile(bitrate: 960)
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3,mediaFile4]
        if let newMediaFile = sut.get(mediaFiles: mediaFiles, bitrate: 320) {
            XCTAssertTrue(newMediaFile.bitrate == mediaFile1.bitrate)
            log("MediaFileURL \(String(describing: newMediaFile.url))")
        }
    }
    func test_EmptySelection() {
        let mediaFile1 = VmaxMediaFile(bitrate: 320)
        let mediaFile2 = VmaxMediaFile(bitrate: 640)
        let mediaFile3 = VmaxMediaFile(bitrate: 960)
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3]
        if let newMediaFile = sut.get(mediaFiles: mediaFiles, bitrate: 500) {
            XCTAssertTrue(newMediaFile.bitrate == mediaFile1.bitrate)
            log("MediaFileURL \(String(describing: newMediaFile.url))")
        }
    }
}

extension ExactFirstMatchTests {
    func bitrateExist(mediaFiles: [VmaxMediaFile], bitrate: Int) -> Bool {
        guard let sut = sut else {
            return false
        }
        guard let mediaFile = sut.get(mediaFiles: mediaFiles, bitrate: bitrate) else {
            return false
        }
        return mediaFile.bitrate == bitrate
    }
}
