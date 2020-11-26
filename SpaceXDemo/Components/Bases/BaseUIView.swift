//
//  BaseUIView.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit

open class BaseUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSelf()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSelf()
    }

    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initializeSelf()
    }

    internal func initializeSelf() {
        preconditionFailure("initializeSelf - This method must be overridden")
    }
}
