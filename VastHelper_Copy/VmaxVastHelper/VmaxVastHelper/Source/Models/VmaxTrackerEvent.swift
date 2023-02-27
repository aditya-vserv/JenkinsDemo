//
//  TrackerInfo.swift
//  Vmax
//
//  Created by Cloy Monis on 03/06/21.
//
import Vmax

public struct VmaxTrackerEvent {
    public let event: String
    public var trackerUrl = [String]()
    public var offset: String?
    public init(event: String) {
        self.event = event
    }
    public init(event: String, trackerUrl: [String]) {
        self.event = event
        self.trackerUrl = trackerUrl
    }
    public init?(dict: [String: String]) {
        guard let event = dict["event"] else {
            return nil
        }
        self.event = event
        if let offset = dict["offset"] {
            self.offset = offset
        }
    }
}

extension VmaxTrackerEvent: Equatable {
    public static func == (lhs: VmaxTrackerEvent, rhs: VmaxTrackerEvent) -> Bool {
        if lhs.event == rhs.event && lhs.trackerUrl.containsSameElements(as: rhs.trackerUrl) && lhs.offset == rhs.offset {
            return true
        }
        return false
    }
}

extension VmaxTrackerEvent: Comparable {
    public static func < (lhs: VmaxTrackerEvent, rhs: VmaxTrackerEvent) -> Bool {
        return lhs.event < rhs.event
    }
}

extension VmaxTrackerEvent: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----------------------------------------------------------------------
                        \(String(describing: type(of: self)))
        ----------------------------------------------------------------------
        event:\(String(describing: event))
        trackerUrl:\(String(describing: trackerUrl))
        offset:\(String(describing: offset))
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
        """
    }
}
