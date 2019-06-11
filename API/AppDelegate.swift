//
//  AppDelegate.swift
//  API
//
//  Created by Daniil G on 07/06/2019.
//  Copyright © 2019 Daniil G. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let model = window?.rootViewController as? MainView {
            model.videoController = VideoController()
        }
        if let model = window?.rootViewController as? ShowAboutVideoView {
            model.videoOptionsController = VideoOptionsController()
        }
        return true
    }
}
