//
//  VmaxVastTrackingEvents.swift
//  Vmax
//
//  Created by Cloy Monis on 03/06/21.
//

public enum VmaxVastTrackingEvents: String {
    case creativeView
    case start
    case complete
    case midpoint
    case firstQuartile
    case thirdQuartile
    case mute
    case unmute
    case pause
    case resume
    case close
    case closeLinear
    case progress
    case offset
    case expand
    case collapse
    case skip
    case click
    case companionCreativeView = "CompanionCreativeView"
    case companionClose
    case companionClickTracking = "CompanionClickTracking"
    case clickTracking = "ClickTracking"
}

extension VmaxVastTrackingEvents: CaseIterable {}
