//
//  VastParser.swift
//  Vmax
//
//  Created by Cloy Monis on 25/05/21.
//

import Foundation
import Vmax

let vastDispatchQueue = DispatchQueue(label: "com.vmax.vasthelper", attributes: .concurrent)

public class VmaxVastParser: NSObject {
    var vmaxXmlParser: VmaxXmlParser?
    public init(data: Data) {
        log("")
        self.vmaxXmlParser = VmaxXmlParser(data: data)
        super.init()
    }
    deinit {
        log("")
    }
    public func startParsing(completionHandler: @escaping (Result<VmaxVastModel, VmaxError>) -> Void) {
        log("")
        vastDispatchQueue.async {
            self.vmaxXmlParser?.startParsing(completionHandler: completionHandler)
        }
    }
}
