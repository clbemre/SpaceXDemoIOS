//
//  BaseCollectionViewCell.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    class var reuseIdentifier: String {
        return "\(self)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialeSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialeSelf() {
        preconditionFailure("initialeSelf - This method must be overridden")
    }

}
