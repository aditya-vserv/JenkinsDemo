//
//  VmaxMediaFileSelection.swift
//  Vmax
//
//  Created by Cloy Monis on 01/07/21.
//

import UIKit
import Vmax

public class VmaxMediaFileSelection: NSObject {
    private var connectionType: ConnectionType
    private var bitrate: Int?
    private var deviceType: DeviceType?
    private let exactFirstMatch: MediaFileAlgorithm
    private let closestMatchByDifference: MediaFileAlgorithm
    private let supportedMedias: FilterMediaFiles
    private let progressiveMedias: FilterMediaFiles
    private let streamingMedias: FilterMediaFiles
    private let cacheEnabled = false
    public init(connectionType: ConnectionType? = nil, bitrate: Int? = nil, deviceType: DeviceType? = nil) {
        self.bitrate = bitrate
        if let connectionType = connectionType {
            self.connectionType = connectionType
        } else {
            let vmaxDevice = VmaxManager.shared.getVmaxDevice()
            self.connectionType = vmaxDevice.getConnectionType() ?? NetworkStatusFetcher().fetch()
        }
        self.deviceType = deviceType
        self.exactFirstMatch = ExactFirstMatch()
        self.closestMatchByDifference = ClosestMatchByDifference()
        self.progressiveMedias = FilterProgressiveMediaFiles()
        self.streamingMedias = FilterStreamingMediaFiles()
        self.supportedMedias = FilterSupportedMediaFiles()
    }
    deinit {
        log("")
    }
    public func fetch(mediaFiles: [VmaxMediaFile]) -> Result<VmaxMediaFile, VmaxError> {
        if mediaFiles.isEmpty {
            let error = VmaxMediaFileError(code: .mediaSelectFailEmptyArrayPassed)
            return .failure(error)
        }
        let error = VmaxMediaFileError(code: .mediaSelectFailedGeneralError)
        let selection = VmaxMediaFileSelectionValidations()
        let resultValidations = selection.validate(mediaFiles: mediaFiles, deviceType: self.deviceType)
        if case .failure(let error) = resultValidations {
            return .failure(error)
        }
        guard case .success(let deviceType) = resultValidations else {
            return .failure(error)
        }
        let streamingFiles = self.streamingMedias.get(mediaFiles: mediaFiles)
        if streamingFiles.count > 0 {
            let mediaFile = streamingFiles[Int.random(in: 0..<streamingFiles.count)]
            log("deviceType:\(deviceType) connectionType: \(connectionType) media: \(mediaFile)")
            return .success(mediaFile)
        }
        let supportedFiles = self.supportedMedias.get(mediaFiles: mediaFiles)
        let filteredMediaFiles = cacheEnabled ? progressiveMedias.get(mediaFiles: supportedFiles): supportedFiles
        let resultBitrate = BitratesTables().getBitrate(deviceType: deviceType, connectionType: self.connectionType)
        if case .failure(let error) = resultBitrate {
            return .failure(error)
        }
        guard case .success(let bitrateRequired) = resultBitrate else {
            return .failure(error)
        }
        if let mediaFile = self.exactFirstMatch.get(mediaFiles: filteredMediaFiles, bitrate: bitrateRequired) {
            log("deviceType:\(deviceType) connectionType: \(connectionType) bitrate: \(bitrateRequired) media: \(mediaFile)")
            return .success(mediaFile)
        }
        if let mediaFile = self.closestMatchByDifference.get(mediaFiles: filteredMediaFiles, bitrate: bitrateRequired) {
            log("deviceType:\(deviceType) connectionType: \(connectionType) bitrate: \(bitrateRequired) media: \(mediaFile)")
            return .success(mediaFile)
        }
        return .failure(error)
    }
}
