//
//  BitratesTables.swift
//  Vmax
//
//  Created by Cloy Monis on 02/07/21.
//

import Foundation
import Vmax

class BitratesTables {
    let pad: BitratesForBandwidth
    let phone: BitratesForBandwidth
    init() {
        self.phone = BitratesForBandwidth(m2G: 64, m3G: 128, m4G: 500, m5G: 1200, ethernetOrWifi: 640)
        self.pad = BitratesForBandwidth(m2G: 128, m3G: 160, m4G: 500, m5G: 1200, ethernetOrWifi: 640)
    }
    func getBitrate(deviceType: DeviceType, connectionType: ConnectionType) -> Result<Int, VmaxError> {
        guard let bitrate = self.get(deviceType: deviceType, connectionType: connectionType) else {
            let error = VmaxMediaFileError(code: .mediaSelectFailUnkownBitrate)
            return .failure(error)
        }
        log("bitrate selected:\(bitrate)")
        return .success(bitrate)
    }
    private func get(deviceType: DeviceType, connectionType: ConnectionType) -> Int? {
        switch deviceType {
        case .phone:
            return phone.getBitrate(connectionType: connectionType)
        case .mobileTablet:
            log("", .error)
            return nil
        case .personalComputer:
            log("", .error)
            return nil
        case .connectedTV:
            log("", .error)
            return nil
        case .tablet:
            return pad.getBitrate(connectionType: connectionType)
        case .connectedDevice:
            log("", .error)
            return nil
        case .setupBox:
            log("", .error)
            return nil
        }
    }
}
