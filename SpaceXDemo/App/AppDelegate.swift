//
//  AppDelegate.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startAppRoot()
        
        // NetworkActivityLogger
        initNetworkActivityLogger()
        
        return true
    }

}
