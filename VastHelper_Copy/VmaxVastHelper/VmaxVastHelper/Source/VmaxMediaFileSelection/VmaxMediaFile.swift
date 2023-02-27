//
//  MediaFile.swift
//  Vmax
//
//  Created by Cloy Monis on 24/06/21.
//

// TO_Do write TC to check if two models are equal

import Foundation

public struct VmaxMediaFile {
    public enum MediaType: String {
        case mp4 = "video/mp4"
    }
    public enum MediaDelivery: String {
        case progressive
        case streaming
    }
    public enum MediaCodec: String {
        case h264 = "H.264"
    }
    public var delivery: MediaDelivery?
    public var bitrate: Int
    public var width: Int?
    public var height: Int?
    public var type: MediaType?
    public var url: String?
    public var mediaId: Int?
    public var scalable: UInt?
    public var maintainAspectRatio: UInt?
    public var minBitrate: UInt?
    public var maxBitrate: UInt?
    public var codec: MediaCodec?
    public init(bitrate: Int) {
        self.bitrate = bitrate
    }
    public init(bitrate: Int, dict: [String: String]) {
        self.bitrate = bitrate
        if let identity = dict[VmaxVastParserAttributes.identity.rawValue], let mediaId = Int(identity) {
            self.mediaId = mediaId
        }
        if let delivery = dict[VmaxVastParserAttributes.delivery.rawValue] {
            self.delivery = VmaxMediaFile.MediaDelivery(rawValue: delivery)
        }
        if let val = dict[VmaxVastParserAttributes.height.rawValue], let height = Int(val) {
            self.height = height
        }
        if let val = dict[VmaxVastParserAttributes.width.rawValue], let width = Int(val) {
            self.width = width
        }
        if let mediaType = dict[VmaxVastParserAttributes.type.rawValue] {
            self.type = VmaxMediaFile.MediaType(rawValue: mediaType)
        }
        if let scalable = dict[VmaxVastParserAttributes.scalable.rawValue], let scalable = UInt(scalable) {
            self.scalable = scalable
        }
        if let maintainAspectRatio = dict[VmaxVastParserAttributes.maintainAspectRatio.rawValue], let maintainAspectRatio = UInt(maintainAspectRatio) {
            self.maintainAspectRatio = maintainAspectRatio
        }
    }
}

extension VmaxMediaFile: Equatable {
    public static func == (lhs: VmaxMediaFile, rhs: VmaxMediaFile) -> Bool {
        if lhs.delivery == rhs.delivery &&
            lhs.bitrate == rhs.bitrate &&
            lhs.width == rhs.width &&
            lhs.height == rhs.height &&
            lhs.type == rhs.type &&
            lhs.url == rhs.url &&
            lhs.mediaId == rhs.mediaId &&
            lhs.scalable == rhs.scalable &&
            lhs.maintainAspectRatio == rhs.maintainAspectRatio {
            return true
        }
        return false
    }
}

extension VmaxMediaFile: Comparable {
    public static func < (lhs: VmaxMediaFile, rhs: VmaxMediaFile) -> Bool {
        return lhs.bitrate < rhs.bitrate
    }
}

extension VmaxMediaFile: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                    \(String(describing: Swift.type(of: self)))
        ----------------------------------------------------------------------
        delivery:\(String(describing: delivery))
        bitrate:\(String(describing: bitrate))
        width:\(String(describing: width))
        height:\(String(describing: height))
        type:\(String(describing: type))
        url:\(String(describing: url))
        id:\(String(describing: mediaId))
        scalable:\(String(describing: scalable))
        maintainAspectRatio:\(String(describing: maintainAspectRatio))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}
