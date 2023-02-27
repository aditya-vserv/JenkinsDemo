//
//  MockVmaxVastParser.swift
//  VmaxNGTests
//
//  Created by Cloy Monis on 24/06/21.
//

// swiftlint: disable all
/*
import Foundation
@testable import VmaxVastHelper
@testable import VmaxVideoHelper

class MockVmaxVastParser {
    static let VastTag =
    """
    <VAST xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="vast.xsd" xxxxx>
    </VAST>
    """
    static let InValidCData =
    """
    <VAST xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.iab.com/VAST" version="4.2">
    <InvalidCData>
    <![CDATA[]]>]]>
    </InvalidCData>
    </VAST>
    """
}

enum VmaxVastModelTypes: CaseIterable {
    case adVerifications_4_2
    case categoryVast_4_2
    case inLineSimple_4_2
    case eventTracking_4_2
    case companion_4_2
    case inLineLinear_4_2
    case noWrapper_4_2
    case readyToServe_4_2
    case videoClick_4_2
    case wrapper_4_2
    case eventTracking_3_0
    case adBreak_3_0
    case zee5_2_0
    case wrapper_3_0
}

struct MockVastModel {
    let category: VmaxVastModelTypes
    let endpoint: String
    var vastModel: VmaxVastModel?
}

struct MockVastModelFetcher {
    let adSystem = "iabtechlab"
    let adTitle = "iabtechlab video ad"
    let advertiser = "IAB Sample Company"
    let duration = UInt(16)
    let clickThrough = "https://iabtechlab.com"
    let errorUrls = ["https://example.com/error"]
    let impressionUrls = ["https://example.com/track/impression"]
    let adServingId = "a532d16d-4d7f-4440-bd29-2ec0e693fc80"
    func get(category: VmaxVastModelTypes) -> MockVastModel {
        switch category {
        case .adVerifications_4_2:
            return self.getAdVerifications()
        case .categoryVast_4_2:
            return self.getCategory()
        case .inLineSimple_4_2:
            return self.getInLineSimple()
        case .eventTracking_4_2:
            return self.getEventTracking()
        case .companion_4_2:
            return self.getCompanions()
        case .inLineLinear_4_2:
            return self.getInlineLinear()
        case .noWrapper_4_2:
            return self.getNoWrapper()
        case .readyToServe_4_2:
            return self.getReadyToServe()
        case .videoClick_4_2:
            return self.getVideoClick()
        case .wrapper_4_2:
            return self.getWrapper()
        case .eventTracking_3_0:
            return self.getEventTracking_3_0()
        case .adBreak_3_0:
            return self.getAdBreakVerifications()
        case .zee5_2_0:
            return self.getZee5Verifications()
        case .wrapper_3_0:
            return self.getZeeWrapper()
        }
    }
}

extension MockVastModelFetcher {
    private func getAdVerifications() -> MockVastModel{
        var adVerification = MockVastModel(category: .adVerifications_4_2, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST_4.2/Ad_Verification-test.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        var adModel = VmaxVastAdModel(dict: [:])
        adModel.adId = "20001"
        adModel.sequence = 1
        adModel.adType = VmaxVastAdModel.VmaxVastAdType.inLine
        adModel.adSystem = self.get()
        adModel.pricing = self.get()
        adModel.adServingId = adServingId
        adModel.adTitle = adTitle
        adModel.adVerifications = self.get()
        adModel.advertiser = advertiser
        adModel.errorUrls = self.errorUrls
        adModel.impressions = self.get()
        adModel.extensions = [self.get()]
        adModel.creatives = [self.get()]
        model.ads = [adModel]
        adVerification.vastModel = model
        return adVerification
    }
    private func getCategory() -> MockVastModel{
        var adVerification = MockVastModel(category: .adVerifications_4_2, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST_4.2/Category-test.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        var adModel = VmaxVastAdModel(dict: [:])
        adModel.adId = "20008"
        adModel.sequence = 1
        adModel.adType = VmaxVastAdModel.VmaxVastAdType.inLine
        adModel.adSystem = self.get()
        adModel.adSystem?.version = "1"
        adModel.pricing = self.get()
        adModel.adServingId = "a532d16d-4d7f-4440-bd29-2ec0e693fc82"
        adModel.adTitle = adTitle
        adModel.errorUrls = self.errorUrls
        adModel.impressions = self.get()
        adModel.creatives = [self.get()]
        adModel.categories = [VmaxVastCategory]()
        adModel.categories?.append(VmaxVastCategory(authority: "https://www.iabtechlab.com/categoryauthority", value: "American Cuisine"))
        adModel.categories?.append(VmaxVastCategory(authority: "https://www.iabtechlab.com/categoryauthority", value: "Guitar"))
        adModel.categories?.append(VmaxVastCategory(authority: "https://www.iabtechlab.com/categoryauthority", value: "Vegan"))
        model.ads = [adModel]
        adVerification.vastModel = model
        return adVerification
    }
    private func getInLineSimple() -> MockVastModel{
        var adVerification = MockVastModel(category: .adVerifications_4_2, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST_4.2/Inline_Simple.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        var adModel = VmaxVastAdModel(dict: [:])
        adModel.adId = "20001"
        adModel.adType = VmaxVastAdModel.VmaxVastAdType.inLine
        adModel.adSystem = self.get()
        adModel.adSystem?.version = "1"
        adModel.adServingId = "a532d16d-4d7f-4440-bd29-2ec05553fc80"
        adModel.adTitle = "Inline Simple Ad"
        adModel.advertiser = advertiser
        adModel.errorUrls = self.errorUrls
        adModel.impressions = self.get()
        adModel.creatives = [self.get()]
        adModel.categories = [VmaxVastCategory]()
        adModel.categories?.append(VmaxVastCategory(authority: "https://www.iabtechlab.com/categoryauthority", value: "AD CONTENT description category"))
        model.ads = [adModel]
        adVerification.vastModel = model
        return adVerification
    }
    private func getEventTracking() -> MockVastModel{
        var adVerification = MockVastModel(category: .adVerifications_4_2, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST_4.2/Event_Tracking-test.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        var adModel = VmaxVastAdModel(dict: [:])
        adModel.adId = "20001"
        adModel.adType = VmaxVastAdModel.VmaxVastAdType.inLine
        adModel.adSystem = self.get()
        adModel.adSystem?.version = "1"
        adModel.adServingId = adServingId
        adModel.adTitle = adTitle
        adModel.pricing = self.get()
        adModel.errorUrls = self.errorUrls
        adModel.impressions = self.get()
        adModel.creatives = [self.get()]
        adModel.extensions = [self.get()]
        model.ads = [adModel]
        adVerification.vastModel = model
        return adVerification
    }
    private func getCompanions() -> MockVastModel{
        var adVerification = MockVastModel(category: .adVerifications_4_2, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST_4.2/Inline_Companion_Tag-test.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        model.meta?.xmlnsxs = nil
        let adModel = self.getCompanionVmaxVastAdModel()
        model.ads = [adModel]
        adVerification.vastModel = model
        return adVerification
    }
    private func getCompanionVmaxVastAdModel() -> VmaxVastAdModel{
        var adModel = VmaxVastAdModel(dict: [:])
        adModel.adId = "20004"
        adModel.adType = VmaxVastAdModel.VmaxVastAdType.inLine
        adModel.adSystem = self.get()
        adModel.adSystem?.version = "1"
        adModel.adTitle = ""
        adModel.pricing = self.get()
        adModel.adServingId = adServingId
        adModel.errorUrls = self.errorUrls
        adModel.impressions = self.get()
        var linearCreative: VmaxVastCreative = self.get()
        linearCreative.id = "5481"
        adModel.creatives = [self.getCompanionCreative(),linearCreative]
        return adModel
    }
    private func getInlineLinear() -> MockVastModel {
        var vastModel = MockVastModel(category: .inLineLinear_4_2, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST_4.2/Inline_Linear_Tag-test.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        var adModel = VmaxVastAdModel(dict: [:])
        adModel.adId = "20001"
        adModel.sequence = 1
        adModel.adType = VmaxVastAdModel.VmaxVastAdType.inLine
        adModel.adSystem = self.get()
        adModel.adSystem?.version = "1"
        adModel.adTitle = adTitle
        adModel.pricing = self.get()
        adModel.adServingId = adServingId
        adModel.errorUrls = self.errorUrls
        adModel.impressions = self.get()
        adModel.extensions = [self.get()]
        var linearCreative: VmaxVastCreative = self.get()
        linearCreative.id = "5480"
        adModel.creatives = [linearCreative]
        model.ads = [adModel]
        vastModel.vastModel = model
        return vastModel
    }
    private func getNoWrapper() -> MockVastModel {
        var vastModel = MockVastModel(category: .noWrapper_4_2, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST_4.2/No_Wrapper_Tag-test.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        var adModel = VmaxVastAdModel(dict: [:])
        adModel.adId = "20001"
        adModel.adType = VmaxVastAdModel.VmaxVastAdType.inLine
        adModel.adSystem = self.get()
        adModel.adSystem?.version = "1"
        adModel.adTitle = adTitle
        adModel.pricing = self.get()
        adModel.adServingId = adServingId
        adModel.errorUrls = self.errorUrls
        adModel.impressions = self.get()
        var linearCreative: VmaxVastCreative = self.get()
        linearCreative.id = "5480"
        adModel.creatives = [linearCreative]
        model.ads = [adModel]
        vastModel.vastModel = model
        return vastModel
    }
    private func getReadyToServe() -> MockVastModel {
        var vastModel = MockVastModel(category: .readyToServe_4_2, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST_4.2/Ready_to_serve_Media_Files_check-test.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        var adModel = VmaxVastAdModel(dict: [:])
        adModel.adId = "20007"
        adModel.adType = VmaxVastAdModel.VmaxVastAdType.inLine
        adModel.adSystem = self.get()
        adModel.adSystem?.version = "2"
        adModel.adTitle = adTitle
        adModel.pricing = self.get()
        adModel.extensions = [self.get()]
        adModel.adServingId = adServingId
        adModel.errorUrls = self.errorUrls
        adModel.impressions = self.get()
        var linearCreative: VmaxVastCreative = self.get()
        linearCreative.id = "5480"
        adModel.creatives = [linearCreative]
        model.ads = [adModel]
        vastModel.vastModel = model
        return vastModel
    }
    private func getVideoClick() -> MockVastModel {
        var vastModel = MockVastModel(category: .videoClick_4_2, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST_4.2/Video_Clicks_and_click_tracking-Inline-test.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        var adModel = VmaxVastAdModel(dict: [:])
        adModel.adId = "20009"
        adModel.adType = VmaxVastAdModel.VmaxVastAdType.inLine
        adModel.adSystem = self.get()
        adModel.adSystem?.version = "1"
        adModel.adTitle = adTitle
        adModel.pricing = self.get()
        adModel.extensions = [self.get()]
        adModel.adServingId = "a532d16d-4d7f-4440-bd29-2ec0e693fc89"
        adModel.errorUrls = self.errorUrls
        adModel.impressions = self.get()
        var linearCreative: VmaxVastCreative = self.get()
        linearCreative.id = "5480"
        linearCreative.linear?.click = VmaxVastVideoClick(dict: [:])
        linearCreative.linear?.click?.id = "blog"
        linearCreative.linear?.click?.clickThroughUrl = "https://iabtechlab.com"
        linearCreative.linear?.click?.trackerUrl = ["http://myTrackingURL/clickTracking"]
        adModel.creatives = [linearCreative]
        adModel.categories = [VmaxVastCategory]()
        adModel.categories?.append(VmaxVastCategory(authority: "https://www.iabtechlab.com/categoryauthority", value: "AD CONTENT description category"))
        model.ads = [adModel]
        vastModel.vastModel = model
        return vastModel
    }
    private func getWrapper() -> MockVastModel {
        var vastModel = MockVastModel(category: .wrapper_4_2, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST_4.2/Wrapper_test.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        model.meta?.xmlnsxs = nil
        var wrapperAdModel = VmaxVastAdModel(dict: [:])
        wrapperAdModel.adSystem = self.get()
        wrapperAdModel.adSystem?.version = "4.0"
        wrapperAdModel.adId = "20011"
        wrapperAdModel.sequence = 1
        wrapperAdModel.wrapper = VmaxVastWrapper(attributes: ["followAdditionalWrappers": "0", "fallbackOnNoAd": "0", "allowMultipleAds": "1"])
        wrapperAdModel.wrapper?.vastAdTagUri = "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST_4.2/Inline_Companion_Tag-test.xml"
        wrapperAdModel.errorUrls = errorUrls
        wrapperAdModel.adType = VmaxVastAdModel.VmaxVastAdType.wrapper
        wrapperAdModel.impressions = self.get()
        wrapperAdModel.creatives = [self.getCompanionCreative(dictionary: ["id": "1232", "assetWidth": "250", "width": "100", "adSlotId": "3214", "apiFramework": "SIMID", "pxratio": "1400", "height": "150", "expandedHeight": "250", "assetHeight": "200", "expandedWidth": "350"])]
        let adModel = self.getCompanionVmaxVastAdModel()
        model.ads = [wrapperAdModel, adModel]
        vastModel.vastModel = model
        return vastModel
    }
    private func getEventTracking_3_0() -> MockVastModel {
        var adVerification = MockVastModel(category: .eventTracking_3_0, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST+3.0+Samples/Event_Tracking-test.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        model.meta?.version = 3.0
        model.meta?.xmlns = nil
        var adModel = VmaxVastAdModel(dict: [:])
        adModel.adId = "20001"
        adModel.adType = VmaxVastAdModel.VmaxVastAdType.inLine
        adModel.adSystem = self.get()
        adModel.adSystem?.version = "4.0"
        adModel.adTitle = adTitle
        adModel.pricing = self.get()
        adModel.errorUrls = ["http://example.com/error"]
        var imp = VmaxVastImpression(dict: [:])
        imp.id = "Impression-ID"
        imp.data = "http://example.com/track/impression"
        adModel.impressions = [imp]
        adModel.creatives = [self.get(vast3_0: true)]
        adModel.extensions = [self.get()]
        model.ads = [adModel]
        adVerification.vastModel = model
        return adVerification
    }
}

extension MockVastModelFetcher {
    private func getCompanionCreative(dictionary: [String: String]? = nil) -> VmaxVastCreative {
        let dict = ["id": "1232", "expandedHeight": "250", "assetHeight": "200", "height": "150", "pxratio": "1400", "expandedWidth": "350", "width": "100", "adSlotId": "3214", "assetWidth": "250"]
        var creative = VmaxVastCreative(dict: [:])
        creative.id = "5480"
        creative.sequence = 1
        creative.adId = "2447226"
        creative.companion = VmaxVastCompanionAd()
        var comp = VmaxVastCreativeCompanion(dict: dict)
        comp.staticResource = VmaxVastStaticResource(dict: [:])
        comp.staticResource?.creativeType = "image/png"
        comp.staticResource?.data = "https://www.iab.com/wp-content/uploads/2014/09/iab-tech-lab-6-644x290.png"
        comp.companionClickThrough = "https://iabtechlab.com"
        creative.companion?.companions = [comp]
        return creative
    }
    private func get(vast3_0: Bool = false) -> VmaxVastCreative {
        var creative = VmaxVastCreative(dict: [:])
        creative.id = "5480"
        creative.sequence = 1
        if vast3_0 == false {
            creative.adId = "2447226"
        }
        var linear = VmaxVastCreativeLinear()
        if vast3_0 == false {
            linear.trackingEvents = self.get()
        }else{
            linear.trackingEvents = self.getVast_3_0()
        }
        if vast3_0 == true {
            linear.mediaFiles = [self.get()]
        }else {
            linear.mediaFiles = self.get()
        }
        linear.duration = duration
        linear.click = self.get()
        creative.linear = linear
        return creative
    }
    private func get() -> VmaxVastExtension {
        var ext = VmaxVastExtension(dict: [:])
        ext.type = "iab-Count"
        ext.name = "total_available"
        ext.value = "2"
        return ext
    }
    private func get() -> VmaxVastVideoClick{
        var click = VmaxVastVideoClick(dict: [:])
        click.id = "blog"
        click.clickThroughUrl = "https://iabtechlab.com"
        return click
    }
    private func get() -> [VmaxVastImpression]{
        var res = [VmaxVastImpression]()
        var imp = VmaxVastImpression(dict: [:])
        imp.id = "Impression-ID"
        imp.data = "https://example.com/track/impression"
        res.append(imp)
        return res
    }
    private func get() -> VmaxVastAdSystem {
        var adSystem = VmaxVastAdSystem(dict: [:])
        adSystem.version = "1.0"
        adSystem.system = "iabtechlab"
        return adSystem
    }
    private func get() -> VmaxVastAdVerifications{
        var adVerifications = VmaxVastAdVerifications()
        let arrayVerifications = [VmaxVastVerification(javaScriptResource: "https://verificationcompany1.com/verification_script1.js"), VmaxVastVerification(javaScriptResource: "https://verificationcompany.com/untrusted.js")]
        adVerifications.verifications = arrayVerifications
        return adVerifications
    }
    private func get() -> VmaxVastMetaData{
        var meta = VmaxVastMetaData(dict: [ : ])
        meta.version = 4.2
        meta.xmlns = "http://www.iab.com/VAST"
        meta.xmlnsxs = "http://www.w3.org/2001/XMLSchema"
        return meta
    }
    private func get() -> VmaxPricing{
        var pricing = VmaxPricing(dict: [:])
        pricing.model = "cpm"
        pricing.currency = "USD"
        pricing.price = "25.00"
        return pricing
    }
    private func get() -> VmaxMediaFile{
        var mediaFile1 = VmaxMediaFile(bitrate: 500)
        mediaFile1.mediaId = 5241
        mediaFile1.delivery = .progressive
        mediaFile1.type = .mp4
        mediaFile1.width = 400
        mediaFile1.height = 300
        mediaFile1.minBitrate = 1500
        mediaFile1.maxBitrate = 2500
        mediaFile1.scalable = 1
        mediaFile1.maintainAspectRatio = 1
        mediaFile1.codec = .h264
        mediaFile1.url = "https://iab-publicfiles.s3.amazonaws.com/vast/VAST-4.0-Short-Intro.mp4"
        return mediaFile1
    }
    private func get() -> [VmaxMediaFile] {
        var res = [VmaxMediaFile]()
        var mediaFile1 = VmaxMediaFile(bitrate: 2000)
        mediaFile1.mediaId = 5241
        mediaFile1.delivery = .progressive
        mediaFile1.type = .mp4
        mediaFile1.width = 1280
        mediaFile1.height = 720
        mediaFile1.minBitrate = 1500
        mediaFile1.maxBitrate = 2500
        mediaFile1.scalable = 1
        mediaFile1.maintainAspectRatio = 1
        mediaFile1.codec = .h264
        mediaFile1.url = "https://iab-publicfiles.s3.amazonaws.com/vast/VAST-4.0-Short-Intro.mp4"
        res.append(mediaFile1)
        var mediaFile2 = VmaxMediaFile(bitrate: 1000)
        mediaFile2.mediaId = 5244
        mediaFile2.delivery = .progressive
        mediaFile2.type = .mp4
        mediaFile2.width = 854
        mediaFile2.height = 480
        mediaFile2.minBitrate = 700
        mediaFile2.maxBitrate = 1500
        mediaFile2.scalable = 1
        mediaFile2.maintainAspectRatio = 1
        mediaFile2.codec = .h264
        mediaFile2.url = "https://iab-publicfiles.s3.amazonaws.com/vast/VAST-4.0-Short-Intro-mid-resolution.mp4"
        res.append(mediaFile2)
        var mediaFile3 = VmaxMediaFile(bitrate: 600)
        mediaFile3.mediaId = 5246
        mediaFile3.delivery = .progressive
        mediaFile3.type = .mp4
        mediaFile3.width = 640
        mediaFile3.height = 360
        mediaFile3.minBitrate = 500
        mediaFile3.maxBitrate = 700
        mediaFile3.scalable = 1
        mediaFile3.maintainAspectRatio = 1
        mediaFile3.codec = .h264
        mediaFile3.url = "https://iab-publicfiles.s3.amazonaws.com/vast/VAST-4.0-Short-Intro-low-resolution.mp4"
        res.append(mediaFile3)
        return res
    }
    private func get() -> [VmaxTrackerEvent] {
        var trackingEvents = [VmaxTrackerEvent]()
        let start = VmaxTrackerEvent(event: "start", trackerUrl: ["https://example.com/tracking/start"])
        trackingEvents.append(start)
        var progress = VmaxTrackerEvent(event: "progress", trackerUrl: ["http://example.com/tracking/progress-10"])
        progress.offset = "00:00:10"
        trackingEvents.append(progress)
        let firstQuartile = VmaxTrackerEvent(event: "firstQuartile", trackerUrl: ["https://example.com/tracking/firstQuartile"])
        trackingEvents.append(firstQuartile)
        let midpoint = VmaxTrackerEvent(event: "midpoint", trackerUrl: ["https://example.com/tracking/midpoint"])
        trackingEvents.append(midpoint)
        let thirdQuartile = VmaxTrackerEvent(event: "thirdQuartile", trackerUrl: ["https://example.com/tracking/thirdQuartile"])
        trackingEvents.append(thirdQuartile)
        let complete = VmaxTrackerEvent(event: "complete", trackerUrl: ["https://example.com/tracking/complete"])
        trackingEvents.append(complete)
        return trackingEvents
    }
    private func getVast_3_0() -> [VmaxTrackerEvent] {
        var trackingEvents = [VmaxTrackerEvent]()
        let start = VmaxTrackerEvent(event: "start", trackerUrl: ["http://example.com/tracking/start"])
        trackingEvents.append(start)
        let firstQuartile = VmaxTrackerEvent(event: "firstQuartile", trackerUrl: ["http://example.com/tracking/firstQuartile"])
        trackingEvents.append(firstQuartile)
        let midpoint = VmaxTrackerEvent(event: "midpoint", trackerUrl: ["http://example.com/tracking/midpoint"])
        trackingEvents.append(midpoint)
        let thirdQuartile = VmaxTrackerEvent(event: "thirdQuartile", trackerUrl: ["http://example.com/tracking/thirdQuartile"])
        trackingEvents.append(thirdQuartile)
        let complete = VmaxTrackerEvent(event: "complete", trackerUrl: ["http://example.com/tracking/complete"])
        trackingEvents.append(complete)
        var progress = VmaxTrackerEvent(event: "progress", trackerUrl: ["http://example.com/tracking/progress-10"])
        progress.offset = "00:00:10"
        trackingEvents.append(progress)
        return trackingEvents
    }
}
// ADBREAK
extension MockVastModelFetcher {
    private func getAdBreakVerifications() -> MockVastModel{
        var adVerification = MockVastModel(category: .adBreak_3_0, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST+3.0+Samples/AdBreak-Test.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        model.meta?.version = 3.0
        model.meta?.xmlns = nil
        model.meta?.xmlnsxs = nil
        model.ads = returnAdModelForBreak()
        model.errorUrls = nil
        adVerification.vastModel = model
        return adVerification
    }
    private func returnAdModelForBreak() -> [VmaxVastAdModel] {
        // DEFAULT VAL
        var count = 0
        let adIds = ["1234","23456","34567","32367","42367","41111","4222"]
        let adType = VmaxVastAdModel.VmaxVastAdType.inLine
        var adSystem: VmaxVastAdSystem = self.get()
        adSystem.version = nil
        adSystem.system = "VMAX"
        let pricing: VmaxPricing? = nil
        let adServingId: String? = nil
        let adTitle = "Video upload"
        let adVerifications: VmaxVastAdVerifications? = nil
        let advertiser: String? = nil
        let errorUrls: [String]? = nil
        let impressions:[VmaxVastImpression] = self.getAdBreakImpression()
        let extensions: [VmaxVastExtension]? = nil
        
        // CREATING AN ARRAY OF VmaxVastAdModel
        var adModels = [VmaxVastAdModel]()
        
        for id in adIds {
            var ad = VmaxVastAdModel(dict: [:])
            ad.adId = id
            ad.sequence = nil
            ad.adType = adType
            ad.adSystem = adSystem
            ad.pricing = pricing
            ad.adServingId = adServingId
            ad.adTitle = adTitle
            ad.adVerifications = adVerifications
            ad.advertiser = advertiser
            ad.errorUrls = errorUrls
            ad.impressions = impressions
            ad.extensions = extensions
            ad.creatives = self.getAdBreakCreative(count)
            count += 1
            adModels.append(ad)
        }
        
        return adModels
    }
    private func getAdBreakImpression() -> [VmaxVastImpression]{
        var res = [VmaxVastImpression]()
        var imp = VmaxVastImpression(dict: [:])
        imp.id = nil
        imp.data = "https://rqstg.zee5.vmax.com/delivery/lg.php?b=481593&zoneid=1173&cb=0484853f&ufc=&zae=2&bfm=0&ck_user_type=register&ck_asset_subtype=episode&ck_utm_source=NA&ck_utm_term=&ck_genre=Reality&ck_ca=0-1-197653&ck_bd_source=&ck_utmpageurl_latest=&ck_ad_pos=&ck_show_name=Toofan+Aalaya+2019&ck_video_id=0-1-197653&ck_brand=iPhone&ck_content_length=long_form&ck_translation=en&ck_certificate_type=U&ck_audio_language=mr&ck_model=iPhone+6s&ck_user_language=&ck_channel_id=&ck_is_lat=&ck_cue_point=&ck_content_name=Toofan+Aalaya+2019&ck_utm_medium=NA&ck_dekey=&ck_video_title=Toofan+Aalaya+-+Episode+1+-+April+06+2019+-+Full+Episode&ck_gender=male&ck_aud=&ck_screen_id=&ck_age=26&ck_content_creator=Zee+Entertsourcenment+Enterprises+Ltd&ck_show_id=0-6-1581&ck_age_group=&ck_season_id=0-2-1437&ck_utm_content=&ck_collection_id=&ck_episode_number=1&ck_utm_campsourcegn=NA&ck_app_version=25.8675001.0&bid=zee5.3&ml=vast&tm=0&mn=ZEE5&vr=A-AN-3.15.5&sw=375&sh=667&cnt=22&mser=cdn&vuid=I18b09f1a-9db2-4731-b62a-dae3629decca&advid=18B09F1A-9DB2-4731-B62A-DAE3629DECCA&zt=a&sa=4&dd=0&pid=78131&app=1&ca=4&sp=&ai=com.vmaxtest&fca=1&fcva=1&cpmt=0&cpct=0&cpat=0&cpcvt=0&pb=0.25%7C0.5%7C0.75%7C1.25%7C1.5&srcid=1173.C22&zat=4&avt=3&admt=4&csz=video&vcpi=3&dvb=OnePlus&dvm=A5000&dvmn=5&dvbr=Chrome+Mobile&dvbv=&co=IN&ci=Mumbai&st=Maharashtra&hk=av&apnid=&bs=728x90&c=78131&os=Android&osv=7.1&osid=3&vpi=3&ute=1&bgid=1&uids=%7B%22gaid%22%3A%2218B09F1A-9DB2-4731-B62A-DAE3629DECCA%22%7D&rt=1657004448&dt=3&cai=207947&app=1"
        res.append(imp)
        return res
    }
    private func getAdBreakCreative(_ index: Int) -> [VmaxVastCreative]{
        // DEFAULT VAL
        let adIds = ["1234","23456","34567","32367","42367","41111","4222"]
        let sequences = [1,2,3,4,5,6,7]
        let durations = [UInt(31),UInt(6),UInt(59),UInt(15),UInt(6),UInt(31),UInt(5)]
        let medias = [
            "https://adsmedia.zee5.com/v/vast/78144_1633959471001_sd.mp4?1173.C22_481593_0484853f_A-AN-3.15.5",
            "https://media.zee5.com/v/vast/77051_1628069857345_sd.mp4?1173.C22_481593_0484853f_A-AN-3.15.5",
            "https://media.zee5.com/v/vast/76899_6_2ae5_sd.mp4?1173.C22_481593_0484853f_A-AN-3.15.5",
            "https://media.zee5.com/v/temp/65002_45_hd_1585657494622.mp4?1173.C22_481593_0484853f_A-AN-3.15.5",
            "https://media.zee5.com/v/temp/65002_45_hd_1585664088300.mp4?1173.C22_481593_0484853f_A-AN-3.15.5",
            "https://media.zee5.com/v/vast/76985_2628692ccdf1bc133d09a1578e6e3a94.mp4?1173.C22_481593_0484853f_A-AN-3.15.5",
            "https://media.zee5.com/v/vast/76985_2_77a7_sd.mp4?1173.C22_481593_0484853f_A-AN-3.15.5"
        ]
        
        // CREATING AN ARRAY OF VmaxVastCreative
        var creatives = [VmaxVastCreative]()
        
        var creative = VmaxVastCreative(dict: [:])
        creative.id = adIds[index]
        creative.sequence = sequences[index]
        creative.adId = nil
        creative.apiFramework = nil
        var linear = VmaxVastCreativeLinear()
        linear.trackingEvents = self.getAdBreakTracker(id: adIds[index])
        linear.mediaFiles = [self.getAdBreakMedia(url: medias[index])]
        linear.duration = durations[index]
        linear.click = self.getAdBreakClick()
        creative.linear = linear
        creatives.append(creative)
        
        return creatives
    }
    private func getAdBreakTracker(id: String) -> [VmaxTrackerEvent] {
        var trackingEvents = [VmaxTrackerEvent]()
        let start = VmaxTrackerEvent(event: "start", trackerUrl: ["https://vmax.com/start/\(id)"])
        trackingEvents.append(start)
        let firstQuartile = VmaxTrackerEvent(event: "firstQuartile", trackerUrl: ["https://vmax.com/firstQuartile/\(id)"])
        trackingEvents.append(firstQuartile)
        let midpoint = VmaxTrackerEvent(event: "midpoint", trackerUrl: ["https://vmax.com/midpoint/\(id)"])
        trackingEvents.append(midpoint)
        let thirdQuartile = VmaxTrackerEvent(event: "thirdQuartile", trackerUrl: ["https://vmax.com/thirdQuartile/\(id)"])
        trackingEvents.append(thirdQuartile)
        let mute = VmaxTrackerEvent(event: "mute", trackerUrl: ["https://vmax.com/mute/\(id)"])
        trackingEvents.append(mute)
        let unmute = VmaxTrackerEvent(event: "unmute", trackerUrl: ["https://vmax.com/unmute/\(id)"])
        trackingEvents.append(unmute)
        let pause = VmaxTrackerEvent(event: "pause", trackerUrl: ["https://vmax.com/pause/\(id)"])
        trackingEvents.append(pause)
        let resume = VmaxTrackerEvent(event: "resume", trackerUrl: ["https://vmax.com/resume/\(id)"])
        trackingEvents.append(resume)
        let complete = VmaxTrackerEvent(event: "complete", trackerUrl: ["https://vmax.com/complete/\(id)"])
        trackingEvents.append(complete)
        return trackingEvents
    }
    private func getAdBreakMedia(url: String) -> VmaxMediaFile {
        var mediaFile1 = VmaxMediaFile(bitrate: 434)
        mediaFile1.mediaId = nil
        mediaFile1.delivery = .progressive
        mediaFile1.type = .mp4
        mediaFile1.width = 640
        mediaFile1.height = 480
        mediaFile1.url = url
        return mediaFile1
    }
    private func getAdBreakClick() -> VmaxVastVideoClick {
        var click = VmaxVastVideoClick(dict: [:])
        click.id = nil
        click.trackerUrl = nil
        click.clickThroughUrl = "https://rqstg.zee5.vmax.com/delivery/ck.php?p=2__b=481593__zoneid=1173__cb=0484853f__dc=1800__cd=zee5-a-mb_apso1a-1657004448__c=78131__zae=2__cai=207947__ml=vast__tm=0__mn=ZEE5__vr=A-AN-3.15.5__sw=375__sh=667__cnt=22__mser=cdn__vuid=I18b09f1a-9db2-4731-b62a-dae3629decca__advid=18B09F1A-9DB2-4731-B62A-DAE3629DECCA__zt=a__sa=4__dd=0__pid=78131__app=1__ca=4__sp=__ai=com.vmaxtest__fca=1__fcva=1__cpmt=0__cpct=0__cpat=0__cpcvt=0__pb=0.25%7C0.5%7C0.75%7C1.25%7C1.5__srcid=1173.C22__zat=4__avt=3__admt=4__csz=video__vcpi=3__dvb=OnePlus__dvm=A5000__dvmn=5__dvbr=Chrome+Mobile__dvbv=__co=IN__ci=Mumbai__st=Maharashtra__hk=av__apnid=__bs=728x90__c=78131__os=Android__osv=7.1__osid=3__vpi=3__ute=1__bgid=1__uids=%7B%22gaid%22%3A%2218B09F1A-9DB2-4731-B62A-DAE3629DECCA%22%7D__rt=1657004448__dt=3__ck_user_type=register__ck_asset_subtype=episode__ck_utm_source=NA__ck_utm_term=__ck_genre=Reality__ck_ca=0-1-197653__ck_bd_source=__ck_utmpageurl_latest=__ck_ad_pos=__ck_show_name=Toofan+Aalaya+2019__ck_video_id=0-1-197653__ck_brand=iPhone__ck_content_length=long_form__ck_translation=en__ck_certificate_type=U__ck_audio_language=mr__ck_model=iPhone+6s__ck_user_language=__ck_channel_id=__ck_is_lat=__ck_cue_point=__ck_content_name=Toofan+Aalaya+2019__ck_utm_medium=NA__ck_dekey=__ck_video_title=Toofan+Aalaya+-+Episode+1+-+April+06+2019+-+Full+Episode__ck_gender=male__ck_aud=__ck_screen_id=__ck_age=26__ck_content_creator=Zee+Entertsourcenment+Enterprises+Ltd__ck_show_id=0-6-1581__ck_age_group=__ck_season_id=0-2-1437__ck_utm_content=__ck_collection_id=__ck_episode_number=1__ck_utm_campsourcegn=NA__ck_app_version=25.8675001.0__bid=zee5.3__r="
        return click
    }
}
// PUBMATIC WRAPPER
extension MockVastModelFetcher {
    private func getZeeWrapper() -> MockVastModel {
        var vastModel = MockVastModel(category: .wrapper_4_2, endpoint: "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST+3.0+Samples/ZeeWrapper_1_3_0.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        model.meta?.version = 2.0
        model.meta?.xmlns = nil
        model.meta?.xmlnsxs = nil
        
        let adModel = returnAdModelForZee5()[0]
        
        var wrapperAdModel1 = VmaxVastAdModel(dict: [:])
        wrapperAdModel1.adId = "1"
        wrapperAdModel1.adType = VmaxVastAdModel.VmaxVastAdType.wrapper
        wrapperAdModel1.wrapper = VmaxVastWrapper(attributes: [:])
        wrapperAdModel1.wrapper?.vastAdTagUri = "https://sdk-data.s3.ap-south-1.amazonaws.com/VAST+3.0+Samples/ZeeWrapper_2_3_0.xml"
        wrapperAdModel1.adSystem = self.get()
        wrapperAdModel1.adSystem?.version = nil
        wrapperAdModel1.adSystem?.system = "PubMatic"
        wrapperAdModel1.errorUrls = ["https://vmax.com/error/wrapper1"]
        wrapperAdModel1.extensions = self.zeeWrapperExtension()
        var imp1 = VmaxVastImpression(dict: [:])
        imp1.id = "pubmatic"
        imp1.data = "https://vmax.com/impression/wrapper1"
        wrapperAdModel1.impressions = [imp1]
        wrapperAdModel1.creatives = self.zeeWrapperCreative(wrapper: "wrapper1")
        
        var wrapperAdModel2 = VmaxVastAdModel(dict: [:])
        wrapperAdModel2.adId = "1"
        wrapperAdModel2.adType = VmaxVastAdModel.VmaxVastAdType.wrapper
        wrapperAdModel2.wrapper = VmaxVastWrapper(attributes: [:])
        wrapperAdModel2.wrapper?.vastAdTagUri = "https://vserv-images.s3.amazonaws.com/ot/dv360/62912/78175/vast2.xml"
        wrapperAdModel2.adSystem = self.get()
        wrapperAdModel2.adSystem?.version = nil
        wrapperAdModel2.adSystem?.system = "DBM"
        wrapperAdModel2.errorUrls = ["https://vmax.com/error/wrapper2"]
        var imp2 = VmaxVastImpression(dict: [:])
        imp2.data = "https://vmax.com/impression/wrapper2"
        wrapperAdModel2.impressions = [imp2]
        wrapperAdModel2.creatives = self.zeeWrapperCreative(wrapper: "wrapper2")
        
        model.ads = [wrapperAdModel1, wrapperAdModel2, adModel]
        vastModel.vastModel = model
        return vastModel
    }
    private func zeeWrapperExtension() -> [VmaxVastExtension] {
        var resp = [VmaxVastExtension]()
        
        var exten1 = VmaxVastExtension(dict: [:])
        exten1.type = nil
        exten1.name = "Meta"
        exten1.value = "name=pm-pixel;ver=1.0"
        resp.append(exten1)
        
        var exten2 = VmaxVastExtension(dict: [:])
        exten2.type = nil
        exten2.name = "Meta"
        exten2.value = "name=pm-forcepixel;ver=1.0"
        resp.append(exten2)
        
        return resp
    }
    private func zeeWrapperCreative(wrapper: String) -> [VmaxVastCreative]{
        // CREATING AN ARRAY OF VmaxVastCreative
        var creatives = [VmaxVastCreative]()
        
        var creative = VmaxVastCreative(dict: [:])
        
        var linear = VmaxVastCreativeLinear()
        
        if wrapper == "wrapper2" {
            creative.id = "12"
            creative.sequence = 1
            
            linear.skipOffset = UInt(5)
            linear.duration = UInt(10)
        }
        
        var clicks = VmaxVastVideoClick(dict: [:])
        clicks.trackerUrl = ["https://vmax.com/clicktracking/\(wrapper)"]
        linear.click = clicks
        linear.trackingEvents = zeeWrapperTracker(id: wrapper)
        
        creative.linear = linear
        
        creatives.append(creative)
        
        return creatives
    }
    private func zeeWrapperTracker(id: String) -> [VmaxTrackerEvent] {
        var trackingEvents = [VmaxTrackerEvent]()
        
        let start = VmaxTrackerEvent(event: "start", trackerUrl: ["https://vmax.com/start/\(id)"])
        let firstQuartile = VmaxTrackerEvent(event: "firstQuartile", trackerUrl: ["https://vmax.com/firstQuartile/\(id)"])
        let midpoint = VmaxTrackerEvent(event: "midpoint", trackerUrl: ["https://vmax.com/midpoint/\(id)"])
        let thirdQuartile = VmaxTrackerEvent(event: "thirdQuartile", trackerUrl: ["https://vmax.com/thirdQuartile/\(id)"])
        let mute = VmaxTrackerEvent(event: "mute", trackerUrl: ["https://vmax.com/mute/\(id)"])
        let unmute = VmaxTrackerEvent(event: "unmute", trackerUrl: ["https://vmax.com/unmute/\(id)"])
        let pause = VmaxTrackerEvent(event: "pause", trackerUrl: ["https://vmax.com/pause/\(id)"])
        let resume = VmaxTrackerEvent(event: "resume", trackerUrl: ["https://vmax.com/resume/\(id)"])
        let complete = VmaxTrackerEvent(event: "complete", trackerUrl: ["https://vmax.com/complete/\(id)"])
        let fullscreen = VmaxTrackerEvent(event: "fullscreen", trackerUrl: ["https://vmax.com/fullscreen/\(id)"])
        let acceptInvitation = VmaxTrackerEvent(event: "acceptInvitation", trackerUrl: ["https://vmax.com/acceptInvitation/\(id)"])
        let close = VmaxTrackerEvent(event: "close", trackerUrl: ["https://vmax.com/close/\(id)"])
        let skip = VmaxTrackerEvent(event: "skip", trackerUrl: ["https://vmax.com/skip/\(id)"])
        var progress = VmaxTrackerEvent(event: "progress", trackerUrl: ["https://vmax.com/progress/\(id)"])
        progress.offset = "00:00:10"
        
        if id == "wrapper1" {
            trackingEvents = [start,firstQuartile,midpoint,thirdQuartile,complete]
        } else if id == "wrapper2" {
            trackingEvents = [start,firstQuartile,midpoint,thirdQuartile,complete,mute,unmute,pause,fullscreen,acceptInvitation,close,skip,progress]
        }
        
        return trackingEvents
    }
}
// ZEE5 XML
extension MockVastModelFetcher {
    private func getZee5Verifications() -> MockVastModel{
        var adVerification = MockVastModel(category: .zee5_2_0, endpoint: "https://vserv-images.s3.amazonaws.com/ot/dv360/62912/78175/vast2.xml")
        var model = VmaxVastModel()
        model.meta = self.get()
        model.meta?.version = 2.0
        model.meta?.xmlns = nil
        model.meta?.xmlnsxs = nil
        model.ads = returnAdModelForZee5()
        model.errorUrls = nil
        adVerification.vastModel = model
        return adVerification
    }
    private func returnAdModelForZee5() -> [VmaxVastAdModel] {
        // DEFAULT VAL
        let adType = VmaxVastAdModel.VmaxVastAdType.inLine
        var adSystem: VmaxVastAdSystem = self.get()
        adSystem.version = nil
        adSystem.system = "VMAX"
        let pricing: VmaxPricing? = nil
        let adServingId: String? = nil
        let adTitle: String? = ""
        let adVerifications: VmaxVastAdVerifications? = nil
        let advertiser: String? = nil
        let errorUrls: [String]? = nil
        let impressions:[VmaxVastImpression]? = nil
        let extensions: [VmaxVastExtension]? = nil
        
        // CREATING AN ARRAY OF VmaxVastAdModel
        var adModels = [VmaxVastAdModel]()
        
        var ad = VmaxVastAdModel(dict: [:])
        ad.adId = "481473"
        ad.sequence = nil
        ad.adType = adType
        ad.adSystem = adSystem
        ad.pricing = pricing
        ad.adServingId = adServingId
        ad.adTitle = adTitle
        ad.adVerifications = adVerifications
        ad.advertiser = advertiser
        ad.errorUrls = errorUrls
        ad.impressions = impressions
        ad.extensions = extensions
        ad.creatives = self.getZee5Creative()
        adModels.append(ad)
        
        return adModels
    }
    private func getZee5Creative() -> [VmaxVastCreative]{
        // CREATING AN ARRAY OF VmaxVastCreative
        var creatives = [VmaxVastCreative]()
        
        var creative = VmaxVastCreative(dict: [:])
        creative.id = "481473"
        creative.sequence = 1
        creative.adId = nil
        creative.apiFramework = nil
        var linear = VmaxVastCreativeLinear()
        linear.trackingEvents = [VmaxTrackerEvent]()
        linear.mediaFiles = [self.getZee5Media()]
        linear.duration = UInt(15)
        linear.click = self.getZee5Click()
        creative.linear = linear
        creatives.append(creative)
        
        return creatives
    }
    private func getZee5Media() -> VmaxMediaFile {
        var mediaFile = VmaxMediaFile(bitrate: 1568)
        mediaFile.mediaId = nil
        mediaFile.delivery = .progressive
        mediaFile.type = .mp4
        mediaFile.width = 1920
        mediaFile.height = 1080
        mediaFile.url = "https://adsmedia.zee5.com/v/vast/78302_1655278367066_hd.mp4"
        return mediaFile
    }
    private func getZee5Click() -> VmaxVastVideoClick {
        var click = VmaxVastVideoClick(dict: [:])
        click.id = nil
        click.trackerUrl = nil
        click.clickThroughUrl = "https://zee5.onelink.me/RlQq/ArdhonZEE5"
        return click
    }
}
*/
