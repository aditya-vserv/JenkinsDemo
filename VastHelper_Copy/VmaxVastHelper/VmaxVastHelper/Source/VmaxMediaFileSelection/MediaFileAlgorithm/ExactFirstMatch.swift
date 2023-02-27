//
//  ExactFirstMatch.swift
//  Vmax
//
//  Created by Cloy Monis on 02/07/21.
//

import Foundation

class ExactFirstMatch: MediaFileAlgorithm {
    func get(mediaFiles: [VmaxMediaFile], bitrate: Int) -> VmaxMediaFile? {
        let exactBitrateMatches = mediaFiles.filter { $0.bitrate == bitrate }
        if exactBitrateMatches.count <= 0 {
            return nil
        }
        let index = Int.random(in: 0..<exactBitrateMatches.count)
        if exactBitrateMatches.count > index {
            return exactBitrateMatches[index]
        }
        return nil
    }
}
