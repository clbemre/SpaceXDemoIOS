//
//  BaseTableViewCell.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    class var reuseIdentifier: String {
        return "\(self)"
    }

    class var defaultHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialeSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialeSelf() {
        preconditionFailure("initialeSelf - This method must be overridden")
    }
}
