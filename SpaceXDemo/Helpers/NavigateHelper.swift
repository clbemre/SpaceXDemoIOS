//
//  NavigateHelper.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 26.11.2020.
//

import UIKit

class NavigateHelper {

    private init() { }

    static let shared = NavigateHelper() 

    func createLaunchDetailViewController(pageTitle: String,
                                          flightNumber: Int,
                                          imageUrl: String?) -> LaunchDetailViewController {
        let vc = AppDelegate.sharedContainer.resolve(LaunchDetailViewController.self)!
        vc.pageTitle = pageTitle
        vc.flightNumber = flightNumber
        vc.imageUrl = imageUrl
        return vc
    }
}
