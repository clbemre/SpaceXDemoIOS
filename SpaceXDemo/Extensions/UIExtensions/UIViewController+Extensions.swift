//
//  UIViewController+Extensions.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import UIKit

extension UIViewController {
    
    func showSystemAlertMessage(title: String, message: String, positiveHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: positiveHandler))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
