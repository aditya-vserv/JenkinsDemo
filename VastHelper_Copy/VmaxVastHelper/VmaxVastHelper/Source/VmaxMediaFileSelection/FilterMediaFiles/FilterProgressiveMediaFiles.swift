//
//  FilterProgressiveMediaFiles.swift
//  Vmax
//
//  Created by Cloy Monis on 02/07/21.
//

import Foundation

class FilterProgressiveMediaFiles: FilterMediaFiles {
    func get(mediaFiles: [VmaxMediaFile]) -> [VmaxMediaFile] {
        let type = VmaxMediaFile.MediaDelivery.progressive
        let response = mediaFiles.filter {
            guard let delivery = $0.delivery else {
                return false
            }
            guard delivery == type else {
                return false
            }
            return true
        }
        return response
    }
}

class FilterStreamingMediaFiles: FilterMediaFiles {
    func get(mediaFiles: [VmaxMediaFile]) -> [VmaxMediaFile] {
        let type = VmaxMediaFile.MediaDelivery.streaming
        let response = mediaFiles.filter {
            guard let delivery = $0.delivery else {
                return false
            }
            guard delivery == type else {
                return false
            }
            return true
        }
        return response
    }
}
