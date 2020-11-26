//
//  UIImageView+Extensions.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import Kingfisher

extension UIImageView {

    func downloadImage(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url,
                             placeholder: nil,
                             options: [.transition(.fade(1)), .cacheOriginalImage],
                             progressBlock: nil) { (result) in
                switch result {
                case .success(_):
                    self.contentMode = .scaleAspectFill
                    self.clipsToBounds = true
                case .failure(_):
                    self.image = UIImage(named: "rocket_icon")
                    self.contentMode = .scaleAspectFit
                    self.clipsToBounds = false
                }
            }
        } else {
            self.image = UIImage(named: "rocket_icon")
            self.contentMode = .scaleAspectFit
            self.clipsToBounds = false
        }
    }
}
