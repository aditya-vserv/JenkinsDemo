//
//  BitrateAllocation.swift
//  Vmax
//
//  Created by Cloy Monis on 01/07/21.
//

import Foundation
import Vmax

class BitratesForBandwidth {
    let m2G: Int
    let m3G: Int
    let m4G: Int
    let m5G: Int
    let ethernetOrWifi: Int
    init(m2G: Int, m3G: Int, m4G: Int, m5G: Int, ethernetOrWifi: Int) {
        self.m2G = m2G
        self.m3G = m3G
        self.m4G = m4G
        self.m5G = m5G
        self.ethernetOrWifi = ethernetOrWifi
    }
    func getBitrate(connectionType: ConnectionType) -> Int? {
        log("\(connectionType)")
        switch connectionType {
        case .cellularNetwork2G:
            return self.m2G
        case .unknown:
            log("", .error)
            return nil
        case .ethernet:
            return self.ethernetOrWifi
        case .wifi:
            return self.ethernetOrWifi
        case .cellularNetworkUnkownGeneration:
            log("", .error)
            return nil
        case .cellularNetwork3G:
            return self.m3G
        case .cellularNetwork4G:
            return self.m4G
        case .cellularNetwork5G:
            return self.m5G
        }
    }
}

extension BitratesForBandwidth: Equatable {
    static func == (lhs: BitratesForBandwidth, rhs: BitratesForBandwidth) -> Bool {
        if lhs.m2G == rhs.m2G &&
            lhs.m3G == rhs.m3G &&
            lhs.m4G == rhs.m4G &&
            lhs.m5G == rhs.m5G &&
            lhs.ethernetOrWifi == rhs.ethernetOrWifi {
            return true
        }
        return false
    }
}

extension BitratesForBandwidth: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        ----------------------------------------------------------------------
                    \(String(describing: Swift.type(of: self)))
        ----------------------------------------------------------------------
        2G:\(String(describing: m2G))
        3G:\(String(describing: m3G))
        4G:\(String(describing: m4G))
        5G:\(String(describing: m5G))
        EthernetOrWifi:\(String(describing: ethernetOrWifi))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}
