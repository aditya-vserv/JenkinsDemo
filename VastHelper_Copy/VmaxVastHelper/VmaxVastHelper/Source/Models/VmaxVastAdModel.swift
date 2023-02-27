//
//  InstreamModel.swift
//  Vmax
//
//  Created by Cloy Monis on 03/06/21.
//

// swiftlint:disable file_length

import Vmax

public struct VmaxVastImpression {
    public var id: String?
    public var data: String?
    init(dict: [String: String]) {
        if let id = dict["id"] {
            self.id = id
        }
    }
}

extension VmaxVastImpression: CustomDebugStringConvertible {
    public var debugDescription: String { "id:\(String(describing: id)),data:\(String(describing: data))" }
}

extension VmaxVastImpression: Equatable {
    public static func == (lhs: VmaxVastImpression, rhs: VmaxVastImpression) -> Bool {
        if lhs.id == rhs.id && lhs.data == rhs.data {
            return true
        }
        return false
    }
}

public struct VmaxVastVerification {
    public var javaScriptResource: String?
    public var verificationParam: String?
    public var vendorKey: String?
    func toDictionary() -> NSDictionary {
        let res = NSMutableDictionary()
        if let javaScriptResource = javaScriptResource {
            res["javaScriptResource"] = javaScriptResource
        }
        if let verificationParam = verificationParam {
            res["verificationParam"] = verificationParam
        }
        if let vendorKey = vendorKey {
            res["vendorKey"] = vendorKey
        }
        return res
    }
}

extension VmaxVastVerification: CustomDebugStringConvertible {
    public var debugDescription: String {
        "jSResource:\(String(describing: javaScriptResource)),verParam:\(String(describing: verificationParam)),vendorKey:\(String(describing: vendorKey))"
    }
}

extension VmaxVastVerification: Equatable {
    public static func == (lhs: VmaxVastVerification, rhs: VmaxVastVerification) -> Bool {
        if lhs.javaScriptResource == rhs.javaScriptResource {
            return true
        }
        return false
    }
}

public struct VmaxVastAdVerifications {
    public var verifications: [VmaxVastVerification]?
    public func toNSDictionary() -> [NSDictionary]? {
        guard let verifications = verifications, verifications.count > 0 else {
            return nil
        }
        return verifications.map { $0.toDictionary() }
    }
}

extension VmaxVastAdVerifications: CustomDebugStringConvertible {
    public var debugDescription: String { "verifications:\(String(describing: verifications))" }
}

extension VmaxVastAdVerifications: Equatable {
    public static func == (lhs: VmaxVastAdVerifications, rhs: VmaxVastAdVerifications) -> Bool {
        guard let lhsVer: [VmaxVastVerification] = lhs.verifications, let rhsVer: [VmaxVastVerification] = rhs.verifications else {
            return true
        }
        if lhsVer == rhsVer {
            return true
        }
        return false
    }
}

public struct VmaxVastMetaData {
    public var version: Double?
    public var xmlns: String?
    public var xmlnsxs: String?
    init(dict: [String: String]) {
        if let xmlns = dict[VmaxVastParserAttributes.xmlns.rawValue] {
            self.xmlns = xmlns
        }
        if let xmlnsxs = dict[VmaxVastParserAttributes.xmlnsxs.rawValue] {
            self.xmlnsxs = xmlnsxs
        }
        if let version = dict[VmaxVastParserAttributes.version.rawValue], let version = Double(version) {
            self.version = version
        }
    }
}

extension VmaxVastMetaData: CustomDebugStringConvertible {
    public var debugDescription: String { "version:\(String(describing: version)),xmlns:\(String(describing: xmlns)),xmlnsxs:\(String(describing: xmlnsxs))" }
}

extension VmaxVastMetaData: Equatable {
    public static func == (lhs: VmaxVastMetaData, rhs: VmaxVastMetaData) -> Bool {
        if lhs.version == rhs.version, lhs.xmlns == rhs.xmlns, lhs.xmlnsxs == rhs.xmlnsxs {
            return true
        }
        return false
    }
}

public struct VmaxPricing {
    public var model: String?
    public var currency: String?
    public var price: String?
    init(dict: [String: String]) {
        if let model = dict[VmaxVastParserAttributes.model.rawValue] {
            self.model = model
        }
        if let currency = dict[VmaxVastParserAttributes.currency.rawValue] {
            self.currency = currency
        }
    }
}

extension VmaxPricing: CustomDebugStringConvertible {
    public var debugDescription: String { "model:\(String(describing: model)),currency:\(String(describing: currency)),price:\(String(describing: price))" }
}

extension VmaxPricing: Equatable {
    public static func == (lhs: VmaxPricing, rhs: VmaxPricing) -> Bool {
        if lhs.model == rhs.model, lhs.currency == rhs.currency, lhs.price == rhs.price {
            return true
        }
        return false
    }
}

public struct VmaxVastExtension {
    public var type: String?
    public var name: String?
    public var value: String?
    init(dict: [String: String]) {
        if let type = dict["type"] {
            self.type = type
        }
    }
}

extension VmaxVastExtension: CustomDebugStringConvertible {
    public var debugDescription: String { "type:\(String(describing: type)),name:\(String(describing: name)),value:\(String(describing: value))" }
}

extension VmaxVastExtension: Equatable {
    static public func == (lhs: VmaxVastExtension, rhs: VmaxVastExtension) -> Bool {
        if lhs.type == rhs.type, lhs.name == rhs.name, lhs.value == rhs.value {
            return true
        }
        return false
    }
}

public struct VmaxVastCategory {
    public var authority: String?
    public var value: String?
    init() {}
    init(authority: String, value: String) {
        self.authority = authority
        self.value = value
    }
    init(dict: [String: String]) {
        if let authority = dict[VmaxVastParserAttributes.authority.rawValue] {
            self.authority = authority
        }
    }
}

extension VmaxVastCategory: CustomDebugStringConvertible {
    public var debugDescription: String { "authority:\(String(describing: authority)),value:\(String(describing: value))" }
}

extension VmaxVastCategory: Equatable {
    public static func == (lhs: VmaxVastCategory, rhs: VmaxVastCategory) -> Bool {
        if lhs.authority == rhs.authority, lhs.value == rhs.value {
            return true
        }
        return false
    }
}

public struct VmaxVastModel {
    public var meta: VmaxVastMetaData?
    public var ads: [VmaxVastAdModel]?
    public var errorUrls: [String]?
}

extension VmaxVastModel: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                        \(String(describing: type(of: self)))
        ----------------------------------------------------------------------
        meta:\(String(describing: meta))
        ads:\(String(describing: ads))
        errorUrls:\(String(describing: errorUrls))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}

extension VmaxVastModel: Equatable {
    public static func == (lhs: VmaxVastModel, rhs: VmaxVastModel) -> Bool {
        if lhs.meta == rhs.meta, lhs.ads == rhs.ads, lhs.errorUrls == rhs.errorUrls {
            return true
        }
        return false
    }
}

public struct VmaxVastWrapper {
    public var attributes: [String: String]?
    public var vastAdTagUri: String?
    public let followAdditionalWrappers: Bool
    public let allowMultipleAds: Bool
    public var fallbackOnNoAd: Bool?
}

extension VmaxVastWrapper {
    init(attributes: [String: String]) {
        if let followAdditionalWrappers = attributes[VmaxVastParserAttributes.followAdditionalWrappers.rawValue], followAdditionalWrappers == "0" {
            self.followAdditionalWrappers = false
        } else {
            self.followAdditionalWrappers = true
        }
        if let allowMultipleAds = attributes[VmaxVastParserAttributes.allowMultipleAds.rawValue], allowMultipleAds == "1" {
            self.allowMultipleAds = true
        } else {
            self.allowMultipleAds = false
        }
        if let fallbackOnNoAd = attributes[VmaxVastParserAttributes.fallbackOnNoAd.rawValue], fallbackOnNoAd == "1" {
            self.fallbackOnNoAd = true
        } else {
            self.fallbackOnNoAd = false
        }
    }
}

extension VmaxVastWrapper: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                        \(String(describing: type(of: self)))
        ----------------------------------------------------------------------
        attributes:\(String(describing: attributes))
        vastAdTagUri:\(String(describing: vastAdTagUri))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}

extension VmaxVastWrapper: Equatable {
    public static func == (lhs: VmaxVastWrapper, rhs: VmaxVastWrapper) -> Bool {
        if lhs.attributes == rhs.attributes, lhs.vastAdTagUri == rhs.vastAdTagUri {
            return true
        }
        return false
    }
}

public struct VmaxVastAdSystem {
    public var version: String?
    public var system: String?
    init(dict: [String: String]) {
        if let version = dict[VmaxVastParserAttributes.version.rawValue] {
            self.version = version
        }
    }
}

extension VmaxVastAdSystem: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                        \(String(describing: type(of: self)))
        ----------------------------------------------------------------------
        version:\(String(describing: version))
        system:\(String(describing: system))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}

extension VmaxVastAdSystem: Equatable {
    public static func == (lhs: VmaxVastAdSystem, rhs: VmaxVastAdSystem) -> Bool {
        if lhs.version == rhs.version, lhs.system == rhs.system {
            return true
        }
        return false
    }
}

public struct VmaxVastCreative {
    public var id: String?
    public var adId: String?
    public var sequence: Int?
    public var apiFramework: String?
    public var linear: VmaxVastCreativeLinear?
    public var companion: VmaxVastCompanionAd?
    init(dict: [String: String]) {
        if let id = dict["id"] {
            self.id = id
        }
        if let adId = dict["adId"] {
            self.adId = adId
        }
        if let sequence = dict["sequence"], let sequence = Int(sequence) {
            self.sequence = sequence
        }
    }
}

extension VmaxVastCreative: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                        \(String(describing: type(of: self)))
        ----------------------------------------------------------------------
        id:\(String(describing: id))
        adId:\(String(describing: adId))
        sequence:\(String(describing: sequence))
        apiFramework:\(String(describing: apiFramework))
        linear:\(String(describing: linear))
        companion:\(String(describing: companion))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}

extension VmaxVastCreative: Equatable {
    public static func == (lhs: VmaxVastCreative, rhs: VmaxVastCreative) -> Bool {
        if lhs.id == rhs.id, lhs.adId == rhs.adId, lhs.sequence == rhs.sequence, lhs.apiFramework == rhs.apiFramework, lhs.linear == rhs.linear, lhs.companion == rhs.companion {
            return true
        }
        return false
    }
}

public struct VmaxVastVideoClick {
    public var id: String?
    public var clickThroughUrl: String?
    public var deepLinkUrl: String?
    public var trackerUrl: [String]?
    init(dict: [String: String]) {
        if let id = dict["id"] {
            self.id = id
        }
    }
}

extension VmaxVastVideoClick: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                \(String(describing: Swift.type(of: self)))
        ----------------------------------------------------------------------
        id:\(String(describing: id))
        trackerUrl:\(String(describing: trackerUrl))
        url:\(String(describing: clickThroughUrl))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}

extension VmaxVastVideoClick: Equatable {
    public static func == (lhs: VmaxVastVideoClick, rhs: VmaxVastVideoClick) -> Bool {
        if lhs.id == rhs.id, lhs.trackerUrl == rhs.trackerUrl, lhs.clickThroughUrl == rhs.clickThroughUrl {
            return true
        }
        return false
    }
}

public struct VmaxVastStaticResource {
    public var creativeType: String?
    public var data: String?
    init(dict: [String: String]) {
        if let creativeType = dict["creativeType"] {
            self.creativeType = creativeType
        }
    }
}

extension VmaxVastStaticResource: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                        \(String(describing: type(of: self)))
        ----------------------------------------------------------------------
        creativeType:\(String(describing: creativeType))
        data:\(String(describing: data))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}

extension VmaxVastStaticResource: Equatable {
    public static func == (lhs: VmaxVastStaticResource, rhs: VmaxVastStaticResource) -> Bool {
        if lhs.creativeType == rhs.creativeType, lhs.data == rhs.data {
            return true
        }
        return false
    }
}

public struct VmaxVastCreativeCompanion {
    public var attributes: [String: String]?
    public var staticResource: VmaxVastStaticResource?
    public var companionClickThrough: String?
    public var companionClickTracking: [String]?
    public var adParameters: [String: Any]?
    public var trackingEvents = [VmaxTrackerEvent]()
    public var htmlResource: String?
    public var adSlotId: String?
    init(dict: [String: String]) {
        self.attributes = dict
        self.adSlotId = attributes?["adSlotId"] as? String
    }
}

extension VmaxVastCreativeCompanion: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                        \(String(describing: type(of: self)))
        ----------------------------------------------------------------------
        attributes:\(String(describing: attributes))
        staticResource:\(String(describing: staticResource))
        companionClickThrough:\(String(describing: companionClickThrough))
        companionClickTracking:\(String(describing: companionClickTracking))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}

extension VmaxVastCreativeCompanion: Equatable {
    public static func == (lhs: VmaxVastCreativeCompanion, rhs: VmaxVastCreativeCompanion) -> Bool {
        if lhs.staticResource == rhs.staticResource, lhs.companionClickThrough == rhs.companionClickThrough, lhs.companionClickTracking == rhs.companionClickTracking {
            return true
        }
        return false
    }
}

public struct VmaxVastCompanionAd {
    public var attributes: [String: String]?
    public var companions: [VmaxVastCreativeCompanion]?
}

extension VmaxVastCompanionAd: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                        \(String(describing: type(of: self)))
        ----------------------------------------------------------------------
        attributes:\(String(describing: attributes))
        companions:\(String(describing: companions))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}

extension VmaxVastCompanionAd: Equatable {
    public static func == (lhs: VmaxVastCompanionAd, rhs: VmaxVastCompanionAd) -> Bool {
        if lhs.attributes == rhs.attributes, lhs.companions == rhs.companions {
            return true
        }
        return false
    }
}

public struct VmaxVastCreativeLinear {
    public var skipOffset: UInt?
    public var duration: UInt?
    public var click: VmaxVastVideoClick?
    public var trackingEvents = [VmaxTrackerEvent]()
    public var mediaFiles: [VmaxMediaFile]?
}

extension VmaxVastCreativeLinear: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                        \(String(describing: type(of: self)))
        ----------------------------------------------------------------------
        skipOffset:\(String(describing: skipOffset))
        duration:\(String(describing: duration))
        clicks:\(String(describing: click))
        trackingEvents:\(String(describing: trackingEvents))
        mediaFile:\(String(describing: mediaFiles))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}

extension VmaxVastCreativeLinear: Equatable {
    public static func == (lhs: VmaxVastCreativeLinear, rhs: VmaxVastCreativeLinear) -> Bool {
        if lhs.skipOffset == rhs.skipOffset, lhs.duration == rhs.duration, lhs.click == rhs.click, lhs.trackingEvents == rhs.trackingEvents, lhs.mediaFiles == rhs.mediaFiles {
            return true
        }
        return false
    }
}

public struct VmaxVastAdModel {
    public enum VmaxVastAdType {
        case wrapper
        case inLine
    }
    public var adId: String?
    public var sequence: Int?
    public var adType: VmaxVastAdType?
    public var wrapper: VmaxVastWrapper?
    public var adSystem: VmaxVastAdSystem?
    public var errorUrls: [String]?
    public var extensions: [VmaxVastExtension]?
    public var pricing: VmaxPricing?
    public var adServingId: String?
    public var adTitle: String?
    public var adVerifications: VmaxVastAdVerifications?
    public var advertiser: String?
    public var categories: [VmaxVastCategory]?
    public var impressions: [VmaxVastImpression]?
    public var creatives: [VmaxVastCreative]?
    init(dict: [String: String]) {
        if let id = dict["id"] {
            self.adId = id
        }
        if let sequence = dict["sequence"], let sequence = Int(sequence) {
            self.sequence = sequence
        }
    }
    public func get() -> [VmaxVastCreativeCompanion]? {
        var res = [VmaxVastCreativeCompanion]()
        var companions: [VmaxVastCreativeCompanion]?
        if let creatives = self.creatives {
            for eachCreative in creatives {
                if let unwrappedComp = eachCreative.companion?.companions {
                    companions = unwrappedComp
                }
            }
        }
        if let companions = companions {
            for eachComp in companions {
                res.append(eachComp)
            }
        }
        if res.count > 0 {
            return res
        }
        return nil
    }
}

extension VmaxVastAdModel: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                        \(String(describing: type(of: self)))
        ----------------------------------------------------------------------
        adId:\(String(describing: adId))
        sequence:\(String(describing: sequence))
        adType:\(String(describing: adType))
        wrapper:\(String(describing: wrapper))
        adSystem:\(String(describing: adSystem))
        errorUrls:\(String(describing: errorUrls))
        extensions:\(String(describing: extensions))
        pricing:\(String(describing: pricing))
        adServingId:\(String(describing: adServingId))
        adTitle:\(String(describing: adTitle))
        adVerifications:\(String(describing: adVerifications))
        advertiser:\(String(describing: advertiser))
        category:\(String(describing: categories))
        impressionUrls:\(String(describing: impressions))
        creatives:\(String(describing: creatives))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}

extension VmaxVastAdModel: Equatable {
    public static func == (lhs: VmaxVastAdModel, rhs: VmaxVastAdModel) -> Bool {
        if lhs.adId == rhs.adId &&
            lhs.sequence == rhs.sequence &&
            lhs.adType == rhs.adType &&
            lhs.wrapper == rhs.wrapper &&
            lhs.adSystem == rhs.adSystem &&
            lhs.errorUrls == rhs.errorUrls &&
            lhs.extensions == rhs.extensions &&
            lhs.pricing == rhs.pricing &&
            lhs.adServingId == rhs.adServingId &&
            lhs.adTitle == rhs.adTitle &&
            lhs.adVerifications == rhs.adVerifications &&
            lhs.advertiser == rhs.advertiser &&
            lhs.categories == rhs.categories &&
            lhs.impressions == rhs.impressions &&
            lhs.creatives == rhs.creatives {
            return true
        }
        return false
    }
    static func arraysEqual(lhs: [String]?, rhs: [String]?) -> Bool {
        if lhs == nil && rhs == nil {
            return true
        }
        if let lhs = lhs, let rhs = rhs {
            if lhs.containsSameElements(as: rhs) {
                return true
            }
        }
        return false
    }
}

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}

class VmaxNode<T: Equatable>: Equatable {
    public var value: T
    public var next: VmaxNode<T>?
    public var prev: VmaxNode<T>?
    init(value: T) {
        self.value = value
    }
    public static func == (lhs: VmaxNode<T>, rhs: VmaxNode<T>) -> Bool {
        return lhs.value == rhs.value
    }
}

class DoublyLinkedList<T: Equatable> {
    public var head: VmaxNode<T>?
    public var tail: VmaxNode<T>?
    func append(value: T) {
        let newNode = VmaxNode(value: value)
        guard self.head != nil else {
            self.head = newNode
            self.tail = newNode
            return
        }
        self.tail?.next = newNode
        newNode.prev = self.tail
        self.tail = newNode
    }
    func items() -> [T] {
        guard self.head != nil else {
            return []
        }
        var allItems = [T]()
        var curr = self.head
        while curr != nil, let cur = curr {
            allItems.append(cur.value)
            curr = curr?.next
        }
        return allItems
    }
    func remove(value: T) {
        if let headNode = self.head, headNode.value == value {
            if self.head == self.tail {
                self.head = nil
                self.tail = nil
            } else {
                let nextNode = headNode.next
                nextNode?.prev = nil
                self.head = nextNode
            }
            return
        }
        if let tailNode = self.tail, tailNode.value == value, let previousNode = tailNode.prev {
            previousNode.next = nil
            self.tail = previousNode
            return
        }
        var current = self.tail
        while current != nil, let cur = current {
            if cur.value == value {
                break
            } else {
                current = cur.prev
            }
        }
        if let currentNode = current, let previousNode = currentNode.prev, let nextNode = currentNode.next {
            previousNode.next = nextNode
            currentNode.prev = previousNode
        }
    }
}

extension Array {
    func element(at index: Int) -> Element? {
        guard index >= 0, index < count else {
            return nil
        }
        return self[index]
    }
}

extension String {
    func toSeconds() -> UInt? {
        let array = self.components(separatedBy: ":")
        guard array.count == 3 else {
            return nil
        }
        guard let hours = UInt(array.element(at: 0) ?? ""),
              let minutes = UInt(array.element(at: 1) ?? ""),
              let seconds = UInt(array.element(at: 2) ?? "") else {
            return nil
        }
        return seconds + (minutes * 60) + (hours * 60 * 60)
    }
}
