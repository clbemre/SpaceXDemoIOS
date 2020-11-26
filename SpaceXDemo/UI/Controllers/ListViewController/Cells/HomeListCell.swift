//
//  HomeListCell.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit

class HomeListCell: BaseTableViewCell, ConfigurableCell {

    typealias DataType = LaunchesResponse

    override class var defaultHeight: CGFloat {
        return 120
    }

    let contentImageView: UIImageView = {
        return UIImageView()
    }()

    let rightContainerView: UIView = {
        return UIView()
    }()

    let labelTitle: UILabel = {
        let label = UILabel()
        label.font = FontBook.Roboto.Medium.of(size: 18)
        label.textColor = .black
        return label
    }()

    let labelDescription: UILabel = {
        let label = UILabel()
        label.font = FontBook.Roboto.Regular.of(size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    let labelDate: UILabel = {
        let label = UILabel()
        label.font = FontBook.Roboto.Regular.of(size: 14)
        label.textColor = .black
        return label
    }()

    override func initialeSelf() {
        selectionStyle = .none
        addViews()
        setupConstraints()
    }

    func configure(data: LaunchesResponse) {
        self.contentImageView.downloadImage(imageUrl: data.rocket?.imageUrl ?? "")
        self.labelTitle.text = data.mission_name ?? ""

        let rocketName = data.rocket?.rocket_name ?? ""
        let rocketType = data.rocket?.rocket_type ?? ""
        self.labelDescription.text = "\(rocketName) - \(rocketType)"

        if let launchDate = data.getDateLaunchDate() {
            labelDate.text = launchDate.toString(format: "dd.MM.yyyy")
        }
    }

}

// MARK: Setup UI
private extension HomeListCell {

    func addViews() {
        addSubview(contentImageView)
        addSubview(rightContainerView)
        rightContainerView.addSubview(labelTitle)
        rightContainerView.addSubview(labelDate)
        rightContainerView.addSubview(labelDescription)
    }

    func setupConstraints() {
        // Content Image View
        contentImageView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview()
            maker.width.equalTo(HomeListCell.defaultHeight)
            maker.top.equalToSuperview().offset(12)
            maker.bottom.equalToSuperview().offset(-12)

        }

        // Right Container View
        rightContainerView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(contentImageView.snp.trailing).offset(16)
            maker.trailing.equalToSuperview()
            maker.top.equalTo(contentImageView.snp.top)
            maker.bottom.equalTo(contentImageView.snp.bottom)
        }

        // Label Title
        labelTitle.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalToSuperview().offset(12)
            maker.height.equalTo(21)
        }

        // Label Date
        labelDate.snp.makeConstraints { (maker) in
            maker.bottom.trailing.equalToSuperview()
            maker.height.equalTo(21)
        }

        // Label Description
        labelDescription.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(labelTitle.snp.bottom).offset(4)
            maker.bottom.equalTo(labelDate.snp.top).offset(-4)
        }

    }

}
