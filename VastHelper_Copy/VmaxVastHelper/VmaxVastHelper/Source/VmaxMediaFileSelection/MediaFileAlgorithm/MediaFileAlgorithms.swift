//
//  MediaFileAlgorithms.swift
//  Vmax
//
//  Created by Cloy Monis on 02/07/21.
//

import Foundation

protocol MediaFileAlgorithm {
    func get(mediaFiles: [VmaxMediaFile], bitrate: Int) -> VmaxMediaFile?
}
