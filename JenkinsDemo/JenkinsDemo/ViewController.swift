//
//  ViewController.swift
//  JenkinsDemo
//
//  Created by Admin_Vserv on 07/02/23.
//

import UIKit
import JenkinsFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Jenkins.shared.setupJenkinsFramework()
        print("Xcode Server Setup Complete")
    }

}
