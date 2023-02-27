//
//  FilterUnsupportedMediaFiles.swift
//  Vmax
//
//  Created by Cloy Monis on 02/07/21.
//

import Foundation
import AVKit

class FilterSupportedMediaFiles: FilterMediaFiles {
    func get(mediaFiles: [VmaxMediaFile]) -> [VmaxMediaFile] {
        let supportedMIMEtypes = AVURLAsset.audiovisualMIMETypes()
        let responseMediaFiles = mediaFiles.filter {
            guard let mime = $0.type else {
                return false
            }
            guard supportedMIMEtypes.contains(mime.rawValue) else {
                return false
            }
            return true
        }
        return responseMediaFiles
    }
}
