//
//  ListViewController+SetupUI.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit

internal extension ListViewController {

    func addSubViews() {
        view.addSubview(cvSlider)
        view.addSubview(sliderIndicator)
        view.addSubview(tableViewLaunches)
    }

    func setupConstraints() {
        setupCVSliderConstraints()
        setupSliderIndicator()
        setupTableViewLaunches()
    }

    // Slider
    func setupCVSliderConstraints() {
        cvSlider.snp.makeConstraints { (maker) in
            maker.topSafeArea(view: self.view)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(UIScreen.main.bounds.height / 3.5)
        }
    }

    // Slider Indicator
    func setupSliderIndicator() {
        sliderIndicator.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(cvSlider.snp.bottom)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(61)
        }
    }

    // Table View All Launches
    func setupTableViewLaunches() {
        tableViewLaunches.snp.makeConstraints { (maker) in
            maker.top.equalTo(cvSlider.snp.bottom)
            maker.leading.equalToSuperview().offset(16)
            maker.trailing.equalToSuperview().offset(-16)
            maker.bottomSafeaArea(view: self.view)
        }
    }

}
