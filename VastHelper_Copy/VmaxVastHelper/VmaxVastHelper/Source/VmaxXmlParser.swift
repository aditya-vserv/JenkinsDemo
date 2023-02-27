//
//  VmaxXmlParser.swift
//  VmaxVastHelper
//
//  Created by Cloy Vserv on 28/10/22.
//

// swiftlint:disable file_length function_body_length

import Foundation
import Vmax

class VmaxXmlParser: NSObject {
    var xmlParser: XMLParser
    var dataToParse: Data
    let supportedVASTversions = [1.0, 2.0, 3.0, 4.0, 4.1, 4.2]
    var currentNode = DoublyLinkedList<String>()
    var currentElement: String?
    var completion: ((Result<VmaxVastModel, VmaxError>) -> Void)?
    var trackerEvent: VmaxTrackerEvent?
    var parserError: VmaxError?
    let maxNestedWrappers = 5
    var nextWrapperUrl: String?
    var currentNestedWrapperLevel: Int?
    var currentVastModel: VmaxVastModel?
    var currentVastAdModel: VmaxVastAdModel?
    var allMediaFiles: [VmaxMediaFile]?
    var currentMediaFile: VmaxMediaFile?
    var currentVastExtension: VmaxVastExtension?
    var currentCategory: VmaxVastCategory?
    var currentCreative: VmaxVastCreative?
    var currentImpression: VmaxVastImpression?
    var currentCompanion: VmaxVastCreativeCompanion?
    var allCompanions: [VmaxVastCreativeCompanion]?
    var client: VmaxHttpClient?
    init(data: Data) {
        log("")
        dataToParse = data
        xmlParser = XMLParser(data: data)
    }
    deinit {
        log("")
        client = nil
    }
    func startParsing(completionHandler: @escaping (Result<VmaxVastModel, VmaxError>) -> Void) {
        log("")
        guard let string = String(data: self.dataToParse, encoding: .utf8), string.isEmpty == false else {
            let error = VmaxVastError(code: .XMLParsingError, errorDescription: "", recoveryMessage: "VAST data corrupted.")
            completionHandler(.failure(error))
            return
        }
        completion = completionHandler
        xmlParser.delegate = self
        self.xmlParser.parse()
    }
    func fetchWrapper(wrapperUrl: String) {
        log("wrapperUrl:\(wrapperUrl)")
        let clientModel = VmaxHttpClientModel(endpoint: wrapperUrl)
        self.client = VmaxHttpClient(vmaxHttpClientModel: clientModel)
        client?.fetch { [weak self] result in
            log("result:\(result)")
            guard let self = self else {
                log("self is nil", .error)
                return
            }
            switch result {
            case.success(let data):
                self.xmlParser.abortParsing()
                self.dataToParse = data
                self.xmlParser = XMLParser(data: self.dataToParse)
                self.xmlParser.delegate = self
                self.xmlParser.parse()
            case .failure(let error):
                log("error\(error)")
                let errorToPropogate = VmaxVastError(code: .vastNoResponceFromWraper)
                self.giveError(error: errorToPropogate)
            }
        }
    }
    func attemptWrapper() -> Bool {
        // if currentVastModel?.ads?.first?.wrapper?.followAdditionalWrappers == false {
        //    log("followAdditionalWrappers is false so stoping attempting wrappers")
        //    return false
        // }
        let url = String(describing: self.nextWrapperUrl)
        let level = String(describing: self.currentNestedWrapperLevel)
        log("nextWrapperUrl:\(url), currentNestedWrapperLevel=\(level)")
        guard let wrapperUrl = self.nextWrapperUrl else {
            log("wrapperUrl is nil")
            return false
        }
        self.nextWrapperUrl = nil
        if var currentNestedWrapperLevel = self.currentNestedWrapperLevel {
            if currentNestedWrapperLevel >= maxNestedWrappers {
                log("maxNestedWrappers threshold reached")
                return false
            }
            currentNestedWrapperLevel += 1
            self.currentNestedWrapperLevel = currentNestedWrapperLevel
            fetchWrapper(wrapperUrl: wrapperUrl)
            return true
        } else {
            currentNestedWrapperLevel = 1
            fetchWrapper(wrapperUrl: wrapperUrl)
            return true
        }
    }
    func giveError(error: VmaxError) {
        log("\(error)", .error)
        guard let completion = completion else {
            log("completion is nil", .error)
            return
        }
        parserError = error
        if vastParserError(completion: completion) { return }
    }
}

extension VmaxXmlParser {
    func vastParserError(completion: ((Result<VmaxVastModel, VmaxError>) -> Void)) -> Bool {
        if let error = self.parserError {
            if let code = VmaxVastError.Codes(rawValue: error.code) {
                guard let model = currentVastModel, model.ads?.isEmpty == false else {
                    let errorResponse = VmaxVastError(code: code, errorDescription: error.errorDescription)
                    completion(.failure(errorResponse))
                    return true
                }
                var urls = [String]()
                if let totalAds = model.ads {
                    for eachAd in totalAds {
                        if let errorUrls = eachAd.errorUrls {
                            urls.append(contentsOf: errorUrls.map {$0.replacingOccurrences(of: "{errorcode}", with: "\(error.code)")})
                        }
                    }
                }
                let errorEventTracker = VmaxTracker()
                let errorEvent = VmaxEvent(name: VmaxVastEvent.error.rawValue, httpUrls: urls)
                errorEventTracker.addEvent(event: errorEvent)
                errorEventTracker.fireNotification(eventName: VmaxVastEvent.error.rawValue)
                completion(.failure(error))
                return true
            }
        }
        return false
    }
}

extension VmaxXmlParser: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        log("")
        if currentVastModel == nil {
            currentVastModel = VmaxVastModel()
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        log("")
        guard let completion = completion else {
            log("error")
            return
        }
        if attemptWrapper() {
            return
        }
        if let currentNestedWrapperLevel = self.currentNestedWrapperLevel {
            if currentNestedWrapperLevel >= maxNestedWrappers {
                let error = VmaxVastError(code: .vastWrapperLimitReached)
                giveError(error: error)
                return
            }
        }
        if vastParserError(completion: completion) {
            return
        }
        onCompletionParsing(completion: completion)
    }
    func onCompletionParsing(completion: ((Result<VmaxVastModel, VmaxError>) -> Void)) {
        guard let vastModel = currentVastModel, let ads = vastModel.ads else {
            let error = VmaxVastError(code: .vastUnknownError, errorDescription: "", recoveryMessage: "VAST Data Model is empty.")
            completion(.failure(error))
            return
        }
        let inlineAds = ads.filter { $0.adType == .inLine }
        if inlineAds.count <= 0 {
            let error = VmaxVastError(code: .vastNoResponceFromWraper)
            giveError(error: error)
            return
        }
        completion(.success(vastModel))
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        log("didStartEle nme:\(elementName),nameURI:\(namespaceURI ?? ""),qName:\(qName ?? ""),dict:\(attributeDict)")
        self.currentElement = elementName
        guard let currentElement = currentElement else {
            return
        }
        currentNode.append(value: elementName)
        switch currentElement {
        case VmaxVastParserNodes.vast.rawValue:
            if let val = attributeDict[VmaxVastParserAttributes.version.rawValue], let version = Double(val) {
                if supportedVASTversions.contains(version) == false {
                    let error = VmaxVastError(code: .vastVersionNotSupported)
                    parserError = error
                }
            } else {
                let error = VmaxVastError(code: .vastVersionNotSupported)
                parserError = error
            }
            currentVastModel?.meta = VmaxVastMetaData(dict: attributeDict)
        case VmaxVastParserNodes.adv.rawValue:
            currentVastAdModel = VmaxVastAdModel(dict: attributeDict)
        case VmaxVastParserNodes.inLine.rawValue:
            currentVastAdModel?.adType = VmaxVastAdModel.VmaxVastAdType.inLine
        case VmaxVastParserNodes.wrapper.rawValue:
            currentVastAdModel?.wrapper = VmaxVastWrapper(attributes: attributeDict)
            currentVastAdModel?.adType = VmaxVastAdModel.VmaxVastAdType.wrapper
        case VmaxVastParserNodes.adSystem.rawValue:
            currentVastAdModel?.adSystem = VmaxVastAdSystem(dict: attributeDict)
        case VmaxVastParserNodes.impression.rawValue:
            currentImpression = VmaxVastImpression(dict: attributeDict)
        case VmaxVastParserNodes.vastExtension.rawValue:
            currentVastExtension = VmaxVastExtension(dict: attributeDict)
        case VmaxVastParserNodes.category.rawValue:
            currentCategory = VmaxVastCategory(dict: attributeDict)
        case VmaxVastParserNodes.pricing.rawValue:
            currentVastAdModel?.pricing = VmaxPricing(dict: attributeDict)
        case VmaxVastParserNodes.creative.rawValue:
            currentCreative = VmaxVastCreative(dict: attributeDict)
        case VmaxVastParserNodes.linear.rawValue:
            currentCreative?.linear = VmaxVastCreativeLinear()
            if let offset = attributeDict["skipoffset"] {
                currentCreative?.linear?.skipOffset = offset.toSeconds()
            }
        case VmaxVastParserNodes.tracking.rawValue:
            trackerEvent = VmaxTrackerEvent(dict: attributeDict)
        case VmaxVastParserNodes.videoClicks.rawValue:
            currentCreative?.linear?.click = VmaxVastVideoClick(dict: attributeDict)
        case VmaxVastParserNodes.clickThrough.rawValue:
            if let id = attributeDict["id"] {
                currentCreative?.linear?.click?.id = id
            }
        case VmaxVastParserNodes.mediaFile.rawValue:
            if currentMediaFile == nil {
                let val = attributeDict[VmaxVastParserAttributes.bitrate.rawValue] ?? "0"
                let bitrate = Int(val) ?? 0
                currentMediaFile = VmaxMediaFile(bitrate: bitrate, dict: attributeDict)
            }
        case VmaxVastParserNodes.companion.rawValue:
            currentCompanion = VmaxVastCreativeCompanion(dict: attributeDict)
        case VmaxVastParserNodes.staticResource.rawValue:
            currentCompanion?.staticResource = VmaxVastStaticResource(dict: attributeDict)
        case VmaxVastParserNodes.verification.rawValue:
            var vmaxVastVerification = VmaxVastVerification()
            if currentVastAdModel?.adVerifications == nil {
                currentVastAdModel?.adVerifications = VmaxVastAdVerifications()
                currentVastAdModel?.adVerifications?.verifications = [VmaxVastVerification]()
            }
            if let vendorKey = attributeDict["vendor"] {
                vmaxVastVerification.vendorKey = vendorKey
            }
            currentVastAdModel?.adVerifications?.verifications?.append(vmaxVastVerification)
        default:
            log("currentElements:\(currentElement) not mapped ")
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        log("didEndEle nme:\(elementName),nameURI:\(namespaceURI ?? ""),qName:\(qName ?? "")")
        self.currentElement = elementName
        guard let currentElement = currentElement else {
            return
        }
        currentNode.remove(value: elementName)
        switch currentElement {
        case VmaxVastParserNodes.adv.rawValue:
            if currentVastModel?.ads == nil {
                currentVastModel?.ads = [VmaxVastAdModel]()
            }
            if let vastAdModel = currentVastAdModel {
                currentVastModel?.ads?.append(vastAdModel)
                self.currentVastAdModel = nil
            }
        case VmaxVastParserNodes.impression.rawValue:
            if currentVastAdModel?.impressions == nil {
                currentVastAdModel?.impressions = [VmaxVastImpression]()
            }
            if let impression = currentImpression {
                currentVastAdModel?.impressions?.append(impression)
            }
            currentImpression = nil
        case VmaxVastParserNodes.creative.rawValue:
            if currentVastAdModel?.creatives == nil {
                currentVastAdModel?.creatives = [VmaxVastCreative]()
            }
            currentCreative?.linear?.mediaFiles = allMediaFiles
            if let creative = currentCreative {
                currentVastAdModel?.creatives?.append(creative)
            }
            allMediaFiles = nil
            currentCreative = nil
        case VmaxVastParserNodes.mediaFile.rawValue:
            if allMediaFiles == nil {
                allMediaFiles = [VmaxMediaFile]()
            }
            if let currentMediaFile = currentMediaFile {
                allMediaFiles?.append(currentMediaFile)
            }
            currentMediaFile = nil
        case VmaxVastParserNodes.tracking.rawValue:
            if currentCreative?.linear?.trackingEvents == nil {
                currentCreative?.linear?.trackingEvents = [VmaxTrackerEvent]()
            }
            if let trackerEvent = trackerEvent {
                if trackerEvent.event == "creativeView" {
                    currentCompanion?.trackingEvents.append(trackerEvent)
                } else {
                    currentCreative?.linear?.trackingEvents.append(trackerEvent)
                }
            }
            trackerEvent = nil
        case VmaxVastParserNodes.companionAds.rawValue:
            if currentCreative?.companion == nil {
                currentCreative?.companion = VmaxVastCompanionAd()
            }
            currentCreative?.companion?.companions = allCompanions
            allCompanions = nil
        case VmaxVastParserNodes.companion.rawValue:
            if allCompanions == nil {
                allCompanions = [VmaxVastCreativeCompanion]()
            }
            if let currentCompanion = currentCompanion {
                allCompanions?.append(currentCompanion)
            }
            currentCompanion = nil
        default:
            log("currentElements:\(currentElement) not mapped)")
        }
        self.currentElement = nil
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard let currentElement = currentElement else {
            return
        }
        let stringVal = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard stringVal.isEmpty == false else {
            return
        }
        // log("currentElement:\(currentElement),foundCharacters:\(stringVal)")
        switch currentElement {
        case VmaxVastParserNodes.error.rawValue:
            if currentVastAdModel?.errorUrls == nil {
                currentVastAdModel?.errorUrls = [String]()
            }
            currentVastAdModel?.errorUrls?.append(stringVal)
        case VmaxVastParserNodes.impression.rawValue:
            currentImpression?.data = stringVal
        case VmaxVastParserNodes.adSystem.rawValue:
            if currentVastAdModel?.adSystem == nil {
                currentVastAdModel?.adSystem = VmaxVastAdSystem(dict: [:])
            }
            currentVastAdModel?.adSystem?.system = stringVal
        case VmaxVastParserNodes.adServingId.rawValue:
            currentVastAdModel?.adServingId = stringVal
        case VmaxVastParserNodes.advertiser.rawValue:
            currentVastAdModel?.advertiser = stringVal
        case VmaxVastParserNodes.adTitle.rawValue:
            currentVastAdModel?.adTitle = stringVal
        case VmaxVastParserNodes.category.rawValue:
            if currentVastAdModel?.categories == nil { currentVastAdModel?.categories = [VmaxVastCategory]() }
            if var category = currentCategory {
                category.value = stringVal
                currentVastAdModel?.categories?.append(category)
            }
            currentCategory = nil
        case VmaxVastParserNodes.duration.rawValue:
            currentCreative?.linear?.duration = stringVal.toSeconds()
        case VmaxVastParserNodes.tracking.rawValue:
            trackerEvent?.trackerUrl.append(stringVal)
        default:
            log("currentElements:\(currentElement) not mapped for val:\(stringVal)")
        }
    }
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        guard let currentElement = currentElement,
              let str = String(data: CDATABlock, encoding: .utf8) else {
            return
        }
        let string = str.trimmingCharacters(in: .whitespacesAndNewlines)
        guard string.isEmpty == false else {
            return
        }
        switch currentElement {
        case VmaxVastParserNodes.error.rawValue:
            if currentVastAdModel?.errorUrls == nil {
                currentVastAdModel?.errorUrls = [String]()
            }
            currentVastAdModel?.errorUrls?.append(string)
        case VmaxVastParserNodes.impression.rawValue:
            currentImpression?.data = string
        case VmaxVastParserNodes.adTitle.rawValue:
            currentVastAdModel?.adTitle = string
        case VmaxVastParserNodes.pricing.rawValue:
            currentVastAdModel?.pricing?.price = string
        case VmaxVastParserNodes.tracking.rawValue:
            trackerEvent?.trackerUrl.append(string)
        case VmaxVastParserNodes.mediaFile.rawValue:
            currentMediaFile?.url = string
        case VmaxVastParserNodes.vastAdTagUri.rawValue:
            currentVastAdModel?.wrapper?.vastAdTagUri = string
            nextWrapperUrl = string
        case VmaxVastParserNodes.clickThrough.rawValue:
            currentCreative?.linear?.click?.clickThroughUrl = string
        case VmaxVastParserNodes.clickTracking.rawValue:
            if currentCreative?.linear?.click?.trackerUrl == nil {
                currentCreative?.linear?.click?.trackerUrl = [String]()
            }
            currentCreative?.linear?.click?.trackerUrl?.append(string)
        case VmaxVastParserNodes.javaScriptResource.rawValue:
            if let count = currentVastAdModel?.adVerifications?.verifications?.count, count > 0 {
                let index = count - 1
                if index >= 0 {
                    currentVastAdModel?.adVerifications?.verifications?[index].javaScriptResource = string
                }
            }
        case VmaxVastParserNodes.verificationParameters.rawValue:
            if let count = currentVastAdModel?.adVerifications?.verifications?.count, count > 0 {
                let index = count - 1
                if index >= 0 {
                    currentVastAdModel?.adVerifications?.verifications?[index].verificationParam = string
                }
            }
        case VmaxVastParserNodes.staticResource.rawValue:
            currentCompanion?.staticResource?.data = string
        case VmaxVastParserNodes.htmlResource.rawValue:
            currentCompanion?.htmlResource = string
        case VmaxVastParserNodes.companionClickThrough.rawValue:
            currentCompanion?.companionClickThrough = string
        case VmaxVastParserNodes.companionClickTracking.rawValue:
            if currentCompanion?.companionClickTracking == nil {
                currentCompanion?.companionClickTracking = [String]()
            }
            currentCompanion?.companionClickTracking?.append(string)
        case VmaxVastParserNodes.adParameters.rawValue:
            if let data = string.data(using: String.Encoding.utf8) {
                let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] ?? [String: Any]()
                currentCompanion?.adParameters = json
            }
        default:
            if currentNode.tail?.prev?.value == VmaxVastParserNodes.vastExtension.rawValue {
                if currentElement == "deeplinkurl" {
                    if currentVastAdModel?.adType == .inLine, let creatives = currentVastAdModel?.creatives {
                        let myCreatives = creatives.map { (creative: VmaxVastCreative) -> VmaxVastCreative in
                            var mutable = creative
                            if mutable.linear?.click?.deepLinkUrl == nil {
                                mutable.linear?.click?.deepLinkUrl = string
                            }
                            return mutable
                        }
                        currentVastAdModel?.creatives = myCreatives
                    }
                }
            }
            if currentNode.tail?.prev?.prev?.prev?.value == VmaxVastParserNodes.vastExtension.rawValue {
                currentVastExtension = VmaxVastExtension(dict: [:])
                currentVastExtension?.name = currentElement
                currentVastExtension?.value = string
                if let vastExtension = currentVastExtension {
                    if currentVastAdModel?.extensions == nil {
                        currentVastAdModel?.extensions = [VmaxVastExtension]()
                    }
                    currentVastAdModel?.extensions?.append(vastExtension)
                    self.currentVastExtension = nil
                }
            }
            log("currentElements:\(currentElement) not mapped for val:\(string)")
        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        log("\(parseError)", .error)
        let error = VmaxVastError(code: .XMLParsingError)
        self.giveError(error: error)
    }
}
