//
//  ProgressView.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit
import NVActivityIndicatorView

class CustomProgressView: BaseUIView {

    var activityIndicator: NVActivityIndicatorView?

    override func initializeSelf() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        activityIndicator = NVActivityIndicatorView(frame:
            CGRect(x: frame.width / 2 - 30,
                   y: frame.height / 2 - 30,
                   width: 60,
                   height: 60), type: .ballRotateChase, color: UIColor.white, padding: nil)
    }

}

extension CustomProgressView {

    // MARK: Activity Indicator
    func show(mView: UIView) {
        if let activityIndicator = activityIndicator {
            addSubview(activityIndicator)
            mView.addSubview(self)
            activityIndicator.startAnimating()
        }
    }

    func hide() {
        if let activityIndicator = activityIndicator {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            removeFromSuperview()
        }
    }
}
