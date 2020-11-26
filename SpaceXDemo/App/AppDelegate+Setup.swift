//
//  AppDelegate+Setup.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit
import Swinject

internal extension AppDelegate {

    func startAppRoot() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = AppDelegate.sharedContainer.resolve(ListViewController.self)!
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.tintColor = .darkGray
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }

    func initNetworkActivityLogger() {
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
    }
}

// MARK: Swinject Container
internal extension AppDelegate {

    static var sharedContainer: Container {
        let container = Container()
        container.registerAuthAllComponents()
        return container
    }
}
