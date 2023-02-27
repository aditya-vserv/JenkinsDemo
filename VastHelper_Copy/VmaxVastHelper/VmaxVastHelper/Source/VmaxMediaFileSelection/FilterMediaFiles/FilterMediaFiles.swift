//
//  FilterMediaFiles.swift
//  Vmax
//
//  Created by Cloy Monis on 02/07/21.
//

import Foundation

protocol FilterMediaFiles {
    func get(mediaFiles: [VmaxMediaFile]) -> [VmaxMediaFile]
}
