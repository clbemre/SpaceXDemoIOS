//
//  WindowHelper.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import UIKit

public class WindowHelper {

    public static func getWindow() -> UIWindow? {

        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows
                .filter({ $0.isKeyWindow }).first
            return keyWindow
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

