//
//  VmaxMediaFileSelectionValidations.swift
//  Vmax
//
//  Created by Cloy Monis on 02/07/21.
//

import Foundation
import Vmax

class VmaxMediaFileSelectionValidations {
    func validate(mediaFiles: [VmaxMediaFile], deviceType: DeviceType? = nil) -> Result<DeviceType, VmaxError> {
        if mediaFiles.count == 0 {
            let error = VmaxMediaFileError(code: .mediaSelectFailEmptyArrayPassed)
            return .failure(error)
        }
        if let deviceType = deviceType {
            return .success(deviceType)
        }
        let vmaxDevice: VmaxDevice = VmaxManager.shared.getVmaxDevice()
        guard let deviceType = vmaxDevice.getDeviceType() else {
            let error = VmaxMediaFileError(code: .mediaSelectFailUnkownDeviceType)
            return .failure(error)
        }
        return .success(deviceType)
    }
}
