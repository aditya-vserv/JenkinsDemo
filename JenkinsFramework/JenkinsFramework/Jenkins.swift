//
//  Jenkins.swift
//  JenkinsFramework
//
//  Created by Admin_Vserv on 20/02/23.
//

import Foundation

public class Jenkins: NSObject {
    private override init() {}
    static public var shared: Jenkins = {
        let instance = Jenkins()
        return instance
    }()
    public func setupJenkinsFramework() {
        print("Welcome to Jenkins Framework")
    }
    public func add(a1: Int, a2: Int) -> Int {
        return a1 + a2
    }
    public func sub(a1: Int, a2: Int) -> Int {
        return a1 - a2
    }
    public func multiply(a1: Int, a2: Int) -> Int {
        return a1 * a2
    }
    public func divide(a1: Int, a2: Int) -> Int {
        return a1 / a2
    }
}
