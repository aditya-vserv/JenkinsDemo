//
//  JenkinsFramework.swift
//  JenkinsFramework
//
//  Created by Admin_Vserv on 20/02/23.
//

import Foundation

public class JenkinsFramework: NSObject {
    private override init() {}
    static public var shared: JenkinsFramework = {
        let instance = JenkinsFramework()
        return instance
    }()
    public func setupJenkinsFramework() {
        print("Welcome to Jenkins Framework via Xcode Server")
    }
}
