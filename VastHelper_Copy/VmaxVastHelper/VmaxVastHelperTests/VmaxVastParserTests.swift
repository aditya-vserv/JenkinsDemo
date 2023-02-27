//
//  VmaxVastParserTests.swift
//  VmaxNGTests
//
//  Created by Cloy Monis on 23/06/21.
//

// swiftlint: disable all
import XCTest
@testable import VmaxVastHelper
@testable import Vmax
@testable import VmaxVideoHelper

class VmaxVastParserTests: XCTestCase {
    var sut: VmaxVastParser!
    let inlineVast = "https://sdk-data.s3.ap-south-1.amazonaws.com/SingleWrapper.xml"
    let multiWrapperVast = "https://sdk-data.s3.ap-south-1.amazonaws.com/InlineVast.xml"
    let generalWrapper = "https://sdk-data.s3.ap-south-1.amazonaws.com/GeneralWrapperError.xml"
    let multipleMediaFiles = "https://sdk-data.s3.ap-south-1.amazonaws.com/MultipleMediaFiles.xml"
    override func setUpWithError() throws {
        // sut = VmaxVastParser()
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }
    func test_Init_EmptyData() {
        let errorExpected = VmaxVastError(code: .XMLParsingError)
        vmaxVastParserInitilized(string: "", errorExpected: errorExpected)
    }
    func test_Init_InvalidData() {
        let errorExpected = VmaxVastError(code: .XMLParsingError)
        vmaxVastParserInitilized(string: "Invalid vast", errorExpected: errorExpected)
    }
    func test_vastWrapperLimitReached() {
        let expectation = XCTestExpectation(description: "Parsing Nested Wrapper")
        let client = VmaxHttpClient(vmaxHttpClientModel: VmaxHttpClientModel(endpoint: multiWrapperVast))
        client.fetch { result in
            switch result {
            case .success(let data):
                log("data")
                self.sut = VmaxVastParser(data: data)
                self.sut.startParsing { result in
                    switch result {
                    case .success(_):
                        log("")
                    case .failure(let error):
                        let errorExpected = VmaxVastError(code: .vastWrapperLimitReached)
                        if errorExpected.code == error.code {
                            expectation.fulfill()
                        }
                    }
                }
            case .failure(_):
                log("")
            }
        }
        wait(for: [expectation], timeout: 20.0)
    }
    func test_NestedWrapper() {
        let expectation = XCTestExpectation(description: "Parsing Nested Wrapper")
        let client = VmaxHttpClient(vmaxHttpClientModel: VmaxHttpClientModel(endpoint: inlineVast))
        client.fetch { result in
            switch result {
            case .success(let data):
                log("data")
                self.sut = VmaxVastParser(data: data)
                self.sut.startParsing { result in
                    switch result {
                    case .success(let model):
                        log("--------Response----------")
                        log("\(model)")
                        //XCTFail("failed")
                        expectation.fulfill()
                    case .failure(let error):
                        log("\(error)")
                        XCTAssertNotNil(error)
                        expectation.fulfill()
                    }
                }
            case .failure(_):
                XCTFail("failed")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 20.0)
    }
    func test_vastVASTVersionSupported() {
        let expectation = XCTestExpectation(description: "test_vastVASTVersionNotSupported")
        let versionSupported: [String] = ["1.0", "2.0", "3.0", "4.0"]
        let arrayVastDocs = versionSupported.map {
            MockVmaxVastParser.VastTag.replacingOccurrences(of: "xxxxx", with: "version=\"\($0)\"")
        }
        expectation.expectedFulfillmentCount = arrayVastDocs.count
        for eachDoc in arrayVastDocs {
            guard let data = eachDoc.data(using: .utf8) else {
                XCTFail("failed")
                return
            }
            sut = VmaxVastParser(data: data)
            sut.startParsing { result in
                switch result {
                case .success(_):
                    log("")
                case .failure(let error):
                    if error.code == 900 {
                        expectation.fulfill()
                    }
                }
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    func test_vastVASTVersionNotSupported() {
        let expectation = XCTestExpectation(description: "test_vastVASTVersionNotSupported")
        let versionSupported: [String] = ["5.0", "6.0"]
        let arrayVastDocs = versionSupported.map {
            MockVmaxVastParser.VastTag.replacingOccurrences(of: "xxxxx", with: "version=\"\($0)\"")
        }
        expectation.expectedFulfillmentCount = arrayVastDocs.count
        for eachDoc in arrayVastDocs {
            guard let data = eachDoc.data(using: .utf8) else {
                XCTFail("failed")
                return
            }
            sut = VmaxVastParser(data: data)
            sut.startParsing { result in
                switch result {
                case .success(_):
                    log("")
                case .failure(let error):
                    let errorExpected = VmaxVastError(code: .vastVersionNotSupported)
                    if errorExpected.code == error.code {
                        expectation.fulfill()
                    }
                }
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    func test_vastNoResponceFromWraper() {
        let expectation = XCTestExpectation(description: "test_vastNoResponceFromWraper")
        let client = VmaxHttpClient(vmaxHttpClientModel: VmaxHttpClientModel(endpoint: generalWrapper))
        client.fetch { result in
            switch result {
            case .success(let data):
                log("data")
                self.sut = VmaxVastParser(data: data)
                self.sut.startParsing { result in
                    switch result {
                    case .success(_):
                        log("")
                    case .failure(let error):
                        let errorExpected = VmaxVastError(code: .vastNoResponceFromWraper)
                        if errorExpected.code == error.code {
                            expectation.fulfill()
                        }
                    }
                }
            case .failure(_):
                log("")
            }
        }
        wait(for: [expectation], timeout: 20.0)
    }
    func test_AllMediaFilesParsed() {
        let expectation = XCTestExpectation(description: "test_AllMediaFilesParsed")
        let client = VmaxHttpClient(vmaxHttpClientModel: VmaxHttpClientModel(endpoint: multipleMediaFiles))
        client.fetch { result in
            switch result {
            case .success(let data):
                log("data")
                self.sut = VmaxVastParser(data: data)
                self.sut.startParsing { result in
                    switch result {
                    case .success(let model):
                        guard let count = model.ads?.first?.creatives?.first?.linear?.mediaFiles?.count else {
                            XCTFail("failed")
                            return
                        }
                        log("count:\(count)")
                        XCTAssertEqual(count, 8)
                        expectation.fulfill()
                    case .failure(_):
                        log("")
                        XCTFail("failed")
                    }
                }
            case .failure(_):
                log("")
            }
        }
        wait(for: [expectation], timeout: 20.0)
    }
    /*
    func testAllVast() {
        do {
            for each in VmaxVastModelTypes.allCases {
                try verify(modelType: each)
            }
        } catch {
            
        }
    }
    */
    func testInvalidCData() {
        let expectation = XCTestExpectation(description: "testInvalidCData")
        guard let data = MockVmaxVastParser.InValidCData.data(using: .utf8) else {
            XCTFail("failed")
            return
        }
        sut = VmaxVastParser(data: data)
        sut.startParsing { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error ):
                let errorExpected =  VmaxVastError(code: .XMLParsingError)
                if errorExpected.code == error.code {
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

extension VmaxVastParserTests {
    func vmaxVastParserInitilized(string: String, errorExpected: VmaxError) {
        let data = string.data(using: .utf8)
        let vmaxVastParser = VmaxVastParser(data: data!)
        vmaxVastParser.startParsing { result in
            switch result {
            case .success(_):
                XCTFail("failed")
            case .failure(let error):
                XCTAssertEqual(error.code, errorExpected.code)
            }
        }
    }
    func verify(modelType: VmaxVastModelTypes) throws {
        let expectation = XCTestExpectation(description: "Parsing Ad Verifications")
        let mockVastModel = MockVastModelFetcher().get(category: modelType)
        let client = VmaxHttpClient(vmaxHttpClientModel: VmaxHttpClientModel(endpoint: mockVastModel.endpoint))
        client.fetch { result in
            switch result {
            case .success(let data):
                self.sut = VmaxVastParser(data: data)
                self.sut.startParsing { result in
                    switch result {
                    case .success(let model):
                        log("--------Response----------")
                        log("\(model)")
                        log("------------------")
                        log("--------Hardcoded----------")
                        log("\(String(describing: mockVastModel.vastModel))")
                        log("------------------")
                        XCTAssert(model == mockVastModel.vastModel)
                        expectation.fulfill()
                    case .failure(_):
                        XCTFail("failed")
                        expectation.fulfill()
                    }
                }
            case .failure(_):
                XCTFail("failed")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 20.0)
    }
}
