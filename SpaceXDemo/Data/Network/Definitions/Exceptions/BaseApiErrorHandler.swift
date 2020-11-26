//
//  BaseApiErrorHandler.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import UIKit

class BaseApiErrorHandler {

    private weak var viewController: UIViewController?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }

    func handleHttp401(errorMessage: String) {
        viewController?.showSystemAlertMessage(title: "Error", message: errorMessage)
    }

    func handleHttp500(errorMessage: String) {
        viewController?.showSystemAlertMessage(title: "Error", message: errorMessage)
    }

    func handleHttpElse(errorMessage: String) {
        viewController?.showSystemAlertMessage(title: "Error", message: errorMessage)
    }

    func handleNoInternet(errorMessage: String) {
        viewController?.showSystemAlertMessage(title: "Error", message: errorMessage)
    }

    func handleUndefined(errorMessage: String) {
        viewController?.showSystemAlertMessage(title: "Error", message: errorMessage)
    }
}
