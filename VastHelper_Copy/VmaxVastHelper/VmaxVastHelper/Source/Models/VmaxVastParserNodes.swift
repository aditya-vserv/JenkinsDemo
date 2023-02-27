//
//  VmaxVastParserNodes.swift
//  Vmax
//
//  Created by Cloy Monis on 11/06/21.
//

import Foundation

enum VmaxVastParserNodes: String {
    case vast = "VAST"
    case adv = "Ad"
    case pricing = "Pricing"
    case adSystem = "AdSystem"
    case adServingId = "AdServingId"
    case advertiser = "Advertiser"
    case adTitle = "AdTitle"
    case error = "Error"
    case impression = "Impression"
    case mediaFile = "MediaFile"
    case tracking = "Tracking"
    case linear = "Linear"
    case duration = "Duration"
    case clickThrough = "ClickThrough"
    case clickTracking = "ClickTracking"
    case vastAdTagUri = "VASTAdTagURI"
    case javaScriptResource = "JavaScriptResource"
    case verification = "Verification"
    case verificationParameters = "VerificationParameters"
    case adVerifications = "AdVerifications"
    case vastExtensions = "Extensions"
    case vastExtension = "Extension"
    case category = "Category"
    case creatives = "Creatives"
    case creative = "Creative"
    case inLine = "InLine"
    case videoClicks = "VideoClicks"
    case companionAds = "CompanionAds"
    case staticResource = "StaticResource"
    case companion = "Companion"
    case companionClickThrough = "CompanionClickThrough"
    case companionClickTracking = "CompanionClickTracking"
    case wrapper = "Wrapper"
    case htmlResource = "HTMLResource"
    case adParameters = "AdParameters"
}

extension VmaxVastParserNodes: CaseIterable {}

enum VmaxVastParserAttributes: String {
    case version
    case xmlnsxs = "xmlns:xs"
    case xmlns
    case delivery
    case bitrate
    case width
    case height
    case type
    case url
    case identity = "id"
    case scalable
    case maintainAspectRatio
    case model
    case currency
    case authority
    case value
    case followAdditionalWrappers
    case allowMultipleAds
    case fallbackOnNoAd
}

extension VmaxVastParserAttributes: CaseIterable {}
