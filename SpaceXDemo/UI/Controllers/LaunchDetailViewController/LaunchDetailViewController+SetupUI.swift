//
//  LaunchDetailViewController+SetupUI.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit

internal extension LaunchDetailViewController {

    func addSubViews() {
        view.addSubview(imgBanner)
        view.addSubview(labelBannerTitle)

        view.addSubview(labelLaunchTitle)
        view.addSubview(labelLaunchDate)
        view.addSubview(labelLaunchDescription)
    }

    func setupConstraints() {
        setupBannerImageView()
        setupLabelBannerTitle()

        setupLabelLaunchTitle()
        setupLabelLaunchDate()
        setupLabelLaunchDescription()
    }

    func setupBannerImageView() {
        imgBanner.snp.makeConstraints { (maker) in
            maker.topSafeArea(view: self.view)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(UIScreen.main.bounds.height / 3.5)
        }
    }

    func setupLabelBannerTitle() {
        self.labelBannerTitle.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(imgBanner.snp.centerX)
            maker.bottom.equalTo(imgBanner.snp.bottom).offset(-12)
            maker.height.equalTo(40)
        }
    }

    func setupLabelLaunchTitle() {
        labelLaunchTitle.snp.makeConstraints { (maker) in
            maker.top.equalTo(imgBanner.snp.bottom).offset(16)
            maker.leading.equalToSuperview().offset(16)
            maker.trailing.equalToSuperview().offset(-16)
            maker.height.equalTo(27)
        }
    }

    func setupLabelLaunchDate() {
        labelLaunchDate.snp.makeConstraints { (maker) in
            maker.bottomSafeaArea(view: self.view).offset(-61)
            maker.trailing.equalToSuperview().offset(-16)
            maker.height.equalTo(21)
        }
    }

    func setupLabelLaunchDescription() {
        labelLaunchDescription.snp.makeConstraints { (maker) in
            maker.top.equalTo(labelLaunchTitle.snp.bottom).offset(4)
            maker.leading.equalToSuperview().offset(20)
            maker.trailing.equalToSuperview().offset(-20)
            maker.bottom.greaterThanOrEqualTo(labelLaunchDate.snp.top).offset(-4).priority(999)
            maker.height.equalTo(21).priority(999)
        }
    }

}
