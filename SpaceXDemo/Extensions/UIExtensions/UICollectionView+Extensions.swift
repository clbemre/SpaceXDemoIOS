//
//  UICollectionView+Extensions.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit

extension UICollectionView {

    func registerCell<T: BaseCollectionViewCell>(_ instance: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: instance.reuseIdentifier)
    }

    func generateReusableCell<T: BaseCollectionViewCell>(_ instance: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: instance.reuseIdentifier, for: indexPath) as! T
    }
}
