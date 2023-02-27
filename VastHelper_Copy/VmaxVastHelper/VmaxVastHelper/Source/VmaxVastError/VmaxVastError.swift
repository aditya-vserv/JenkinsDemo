//
//  VmaxVastError.swift
//  VmaxVastHelper
//
//  Created by Cloy Vserv on 08/11/22.
//

import Foundation
import Vmax

public final class VmaxVastError: VmaxError {
    public enum Codes: Int {
        // ..
        // XML parsing error.
        // Used
        case XMLParsingError = 100
        // ..
        // VAST schema validation error.
        case vastSchemaValidation = 101
        // ..
        // VAST version of response not supported.
        // Used
        case vastVersionNotSupported = 102
        // ..
        // Trafficking error. Media player received an Ad type that it was not expecting and/or cannot display.
        case vastUnsupportedVastAd = 200
        // ..
        // Media player expecting different linearity.
        case vastPlayerExpectsDifferentLinearity = 201
        // ..
        // Media player expecting different duration.
        case vastPlayerExpectsDifferentDuration = 202
        // ..
        // Media player expecting different size.
        case vastPlayerExpectsDifferentSize = 203
        // ..
        // Ad category was required but not provided.
        case adCategoryNotProvided = 204
        // ..
        // Inline Category violates Wrapper BlockedAdCategories
        case inLineCategoryViolatesWrapper = 205
        // ..
        // Ad Break shortened. Ad was not served.
        case adBreakShortened = 206
        // ..
        // General Wrapper error.
        case vastGeneralWrapperError = 300
        // ..
        // Timeout of VAST URI provided in Wrapper element, or of VAST URI provided
        // in a subsequent Wrapper element. (URI was either unavailable or reached
        // a timeout as defined by the video player.)
        case vastTimeoutVASTURI = 301
        // ..
        // Wrapper limit reached, as defined by the video player.
        // Too many Wrapper responses have been received with no InLine response.
        // Used
        case vastWrapperLimitReached = 302
        // ..
        // No Ads VAST response after one or more Wrappers.
        // Used
        case vastNoResponceFromWraper = 303
        // ..
        // InLine response returned ad unit that failed to result in ad display within define
        case inLineR = 304
        // ..
        // General Linear error. Video player is unable to display the Linear Ad.
        case vastGeneralLinearError = 400
        // ..
        // File not found. Unable to find Linear/MediaFile from URI.
        case vastMediaFileNotFound = 401
        // ..
        // Timeout of MediaFile URI.
        case vastTimeoutMediaFile = 402
        // ..
        // Couldn’t find MediaFile that is supported by this video player,
        // based on the attributes of the MediaFile element.
        case vastUnsupportedMediaFile = 403
        // ..
        // Problem displaying MediaFile. Video player found a MediaFile with supported type but couldn’t display it.
        // MediaFile may include: unsupported codecs, different MIME type than MediaFile@type,
        // unsupported delivery method, etc.
        case vastMediaCouldNotBePlayed = 405
        // ..
        // Mezzanine was required but not provided. Ad not served.
        case mezzanineNotSupported = 406
        // ..
        // Mezzanine is in the process of being downloaded for the first time. Download may take several hours. Ad will not be served until mezzanine is downloaded and transcoded.
        case mezzanineNotDownloaded = 407
        // ..
        // Conditional ad rejected. (deprecated along with conditionalAd)
        case conditionalAdRejected = 408
        // ..
        // Interactive unit in the InteractiveCreativeFile node was not executed.
        case interactiveUnitNotExecuted = 409
        // ..
        // Verification unit in the Verification node was not executed.
        case verificationNodeNotExecuted = 410
        // ..
        // Mezzanine was provided as required, but file did not meet required specification. Ad not served.
        case mezzanineNotAsSpecification = 411
        // ..
        // General NonLinearAds error.
        case vastGeneralNonLinearAds = 500
        // ..
        // Unable to display NonLinear Ad because creative dimensions
        // do not align with creative display area (i.e. creative dimension too large).
        case vastDimensionsNotAlignedToDisplayArea = 501
        // ..
        // Unable to fetch NonLinearAds/NonLinear resource.
        case vastUnableToFetchNonLinearAd = 502
        // ..
        // Couldn’t find NonLinear resource with supported type.
        case vastUnableToFindNonLinearAdToSuppType = 503
        // ..
        // General CompanionAds error.
        case vastGeneralCompanionAdsError = 600
        // ..
        // Unable to display Companion because creative dimensions do not fit within
        // Companion display area (i.e., no available space).
        case vastCompanionDimNotAlignedToDisplayArea = 601
        // ..
        // Unable to display Required Companion.
        case unableToDisplayCompanionAd = 602
        // ..
        // Unable to fetch CompanionAds/Companion resource.
        case unableToFetchCompanionResource = 603
        // ..
        // Couldn’t find Companion resource with supported type.
        case companionResNotFoundWithSupportedType = 604
        // ..
        // Undefined Error.
        // Used
        case vastUnknownError = 900
        // ..
        //  General VPAID error.
        case generalVPAIDerror = 901
        // ..
        //  General InteractiveCreativeFile error code
        case generalInteractiveCreativeFileError = 902
        // ..
    }
    public init(code: Codes) {
        let errorDescription = getDefaultErrorDescription(code: code)
        let recoveryMessage = getDefaultRecoveryMessage(code: code)
        super.init(code: code.rawValue, errorDescription: errorDescription, recoveryMessage: recoveryMessage)
    }
    public init(code: Codes, errorDescription: String) {
        let recoveryMessage = getDefaultRecoveryMessage(code: code)
        super.init(code: code.rawValue, errorDescription: errorDescription, recoveryMessage: recoveryMessage)
    }
    public init(code: Codes, errorDescription: String, recoveryMessage: String) {
        super.init(code: code.rawValue, errorDescription: errorDescription, recoveryMessage: recoveryMessage)
    }
}

func getDefaultErrorDescription(code: VmaxVastError.Codes) -> String {
    switch code {
    case .XMLParsingError:
        return "XML Parsing Error"
    case .vastVersionNotSupported:
        return "Vast Version Not Supported"
    case .vastWrapperLimitReached:
        return "Vast Wrapper Limit Reached"
    case .vastNoResponceFromWraper:
        return "Vast No Responce From Wraper"
    case .vastUnknownError:
        return "Vast Unknown Error"
    default:
        return ""
    }
}
func getDefaultRecoveryMessage(code: VmaxVastError.Codes) -> String {
    switch code {
    case .XMLParsingError:
        return "XML Parsing Error"
    case .vastVersionNotSupported:
        return "Vast Version Not Supported"
    case .vastWrapperLimitReached:
        return "Vast Wrapper Limit Reached"
    case .vastNoResponceFromWraper:
        return "Vast No Responce From Wraper"
    case .vastUnknownError:
        return "Vast Unknown Error"
    default:
        return ""
    }
}
