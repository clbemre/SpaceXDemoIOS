//
//  SnapKit+Extensions.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import SnapKit

extension ConstraintMaker {
    
    @discardableResult
    func topSafeArea(view: UIView) -> ConstraintMakerEditable {
        return top.equalTo(view.safeAreaLayoutGuide.snp.top)
    }

    @discardableResult
    func bottomSafeaArea(view: UIView) -> ConstraintMakerEditable {
        return bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
}
