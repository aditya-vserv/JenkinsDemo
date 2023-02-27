//
//  ClosestMatchByDifference.swift
//  Vmax
//
//  Created by Cloy Monis on 02/07/21.
//

import Foundation
import Vmax

class ClosestMatchByDifference: MediaFileAlgorithm {
    func get(mediaFiles: [VmaxMediaFile], bitrate: Int) -> VmaxMediaFile? {
        let sortedMediaFiles = mediaFiles.sorted()
        log("sortedMediaFiles:\(sortedMediaFiles)")
        var mediaFiles = [VmaxMediaFile]()
        var mediaFile: VmaxMediaFile?
        var bitDiff: Int?
        for eachFile in sortedMediaFiles {
            var diff = 0
            if eachFile.bitrate > bitrate {
                diff = eachFile.bitrate
            } else {
                diff = bitrate
            }
            log("bit:\(bitrate),each bitrate:\(eachFile.bitrate),diff:\(diff),bitDiff:\(String(describing: bitDiff))")
            if let selectedMediaFileDiff = bitDiff {
                if diff <= selectedMediaFileDiff {
                    mediaFiles.append(eachFile)
                    bitDiff = diff
                }
            } else {
                bitDiff = diff
                mediaFiles.append(eachFile)
            }
        }
        mediaFile = mediaFiles.count > 1 ? mediaFiles[Int.random(in: 0..<mediaFiles.count)] : mediaFiles.first
        return mediaFile
    }
}
