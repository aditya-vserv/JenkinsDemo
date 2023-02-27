//
//  VmaxMediaFileError.swift
//  VmaxVastHelper
//
//  Created by Cloy Vserv on 08/11/22.
//

import Foundation
import Vmax

public final class VmaxMediaFileError: VmaxError {
    public enum Codes: Int {
        case mediaSelectFailedGeneralError = 99000
        case mediaSelectFailEmptyArrayPassed = 99003
        case mediaSelectFailUnkownDeviceType = 99001
        case mediaSelectFailUnkownBitrate = 99002
    }
    public init(code: Codes) {
        let errorDescription = getDefaultErrorDescription(code: code)
        let recoveryMessage = getDefaultRecoveryMessage(code: code)
        super.init(code: code.rawValue, errorDescription: errorDescription, recoveryMessage: recoveryMessage)
    }
    public init(code: Codes, errorDescription: String) {
        let recoveryMessage = getDefaultRecoveryMessage(code: code)
        super.init(code: code.rawValue, errorDescription: errorDescription, recoveryMessage: recoveryMessage)
    }
    public init(code: Codes, errorDescription: String, recoveryMessage: String) {
        super.init(code: code.rawValue, errorDescription: errorDescription, recoveryMessage: recoveryMessage)
    }
}

func getDefaultErrorDescription(code: VmaxMediaFileError.Codes) -> String {
    switch code {
    case .mediaSelectFailedGeneralError:
        return "mediaSelectFailedGeneralError"
    default:
        return ""
    }
}
func getDefaultRecoveryMessage(code: VmaxMediaFileError.Codes) -> String {
    switch code {
    case .mediaSelectFailedGeneralError:
        return "mediaSelectFailedGeneralError"
    default:
        return ""
    }
}
