//
//  ClosestMatchByDifferenceTests.swift
//  VmaxVastHelperTests
//
//  Created by Admin_Vserv on 28/12/22.
//

import XCTest
@testable import VmaxVastHelper
import Vmax

// swiftlint: disable all
class ClosestMatchByDifferenceTests: XCTestCase {
    
    var sut: ClosestMatchByDifference!
    
    override func setUpWithError() throws {
        sut = ClosestMatchByDifference()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

    func test_HappyPath() throws {
        let mediaFile1 = VmaxMediaFile(bitrate: 320)
        let mediaFile2 = VmaxMediaFile(bitrate: 640)
        let mediaFile3 = VmaxMediaFile(bitrate: 960)
        
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3]
        
        if let newMediaFile = sut.get(mediaFiles: mediaFiles, bitrate: 320) {
            XCTAssertTrue(newMediaFile.bitrate == mediaFile1.bitrate)
        } else {
            XCTFail()
        }
        
    }
    
    func test_ImmediateLower() throws {
        let mediaFile1 = VmaxMediaFile(bitrate: 320)
        let mediaFile2 = VmaxMediaFile(bitrate: 640)
        let mediaFile3 = VmaxMediaFile(bitrate: 960)
        
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3]
        
        if let newMediaFile = sut.get(mediaFiles: mediaFiles, bitrate: 500) {
            XCTAssertTrue(newMediaFile.bitrate == mediaFile1.bitrate)
        } else {
            XCTFail()
        }
        
    }
    
    func test_ImmediateLower_ButWithMultipleBitrate() throws {
        var mediaFile1 = VmaxMediaFile(bitrate: 320)
        mediaFile1.url = "320_1.mp4"
        var mediaFile2 = VmaxMediaFile(bitrate: 320)
        mediaFile2.url = "320_2.mp4"
        let mediaFile3 = VmaxMediaFile(bitrate: 640)
        let mediaFile4 = VmaxMediaFile(bitrate: 960)
        
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3,mediaFile4]
        
        if let newMediaFile = sut.get(mediaFiles: mediaFiles, bitrate: 500) {
            XCTAssertTrue(newMediaFile.bitrate == mediaFile1.bitrate)
            log("NewMediaFile URL \(String(describing: newMediaFile.url))")
        } else {
            XCTFail()
        }
        
    }
    
    func test_ImmediateHigher() throws {
        let mediaFile1 = VmaxMediaFile(bitrate: 320)
        let mediaFile2 = VmaxMediaFile(bitrate: 640)
        let mediaFile3 = VmaxMediaFile(bitrate: 960)
        
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3]
        
        if let newMediaFile = sut.get(mediaFiles: mediaFiles, bitrate: 240) {
            XCTAssertTrue(newMediaFile.bitrate == mediaFile1.bitrate)
        } else {
            XCTFail()
        }
        
    }
    
    func test_ImmediateHigher_ButWithMultipleBitrate() throws {
        var mediaFile1 = VmaxMediaFile(bitrate: 320)
        mediaFile1.url = "320_1.mp4"
        var mediaFile2 = VmaxMediaFile(bitrate: 320)
        mediaFile2.url = "320_2.mp4"
        let mediaFile3 = VmaxMediaFile(bitrate: 640)
        let mediaFile4 = VmaxMediaFile(bitrate: 960)
        
        let mediaFiles = [mediaFile1,mediaFile2,mediaFile3,mediaFile4]
        
        if let newMediaFile = sut.get(mediaFiles: mediaFiles, bitrate: 240) {
            XCTAssertTrue(newMediaFile.bitrate == mediaFile1.bitrate)
            log("NewMediaFile URL \(String(describing: newMediaFile.url))")
        } else {
            XCTFail()
        }
        
    }

}
