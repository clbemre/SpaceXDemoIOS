//
//  LaunchDetailViewController.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit

class LaunchDetailViewController: BaseViewController {

    // MARK: Components
    let imgBanner: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return imageView
    }()

    let labelBannerTitle: PaddingLabel = {
        let label = PaddingLabel(withInsets: 8, 8, 8, 8)
        label.font = FontBook.Roboto.Black.of(size: 32)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.textColor = .white
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.isHidden = true
        return label
    }()

    let labelLaunchTitle: UILabel = {
        let label = UILabel()
        label.font = FontBook.Roboto.Medium.of(size: 18)
        label.textColor = .black
        return label
    }()

    let labelLaunchDescription: UILabel = {
        let label = UILabel()
        label.font = FontBook.Roboto.Regular.of(size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    let labelLaunchDate: UILabel = {
        let label = UILabel()
        label.font = FontBook.Roboto.Regular.of(size: 14)
        label.textColor = .black
        return label
    }()

    // MARK: Vars
    var pageTitle: String!
    var viewModel: LaunchDetailViewModel!
    var flightNumber: Int?
    // dummyContent
    var imageUrl: String?

    override func initialComponents() {
        self.view.backgroundColor = .white
        self.title = pageTitle

        self.addSubViews()
        self.setupConstraints()
    }

    override func registerEvents() { }

    override func createdUIInitWithEvents() {

        observeLaunchApiState()

        if let flightNumber = flightNumber {
            self.viewModel.fetchLaunchDetail(flightNumber: flightNumber)
        } else {
            showSystemAlertMessage(title: "", message: "Bir hata oluştu") { _ in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    private func observeLaunchApiState() {
        observeAPIState(apiState: self.viewModel.launcDetailState,
                        callbackLoading: {
                            self.showProgress()
                        },
                        callbackSuccess: { content in
                            var tempContent = content
                            tempContent.rocket?.imageUrl = self.imageUrl
                            self.handleLaunchDetailsByApiResult(model: tempContent)
                        },
                        callbackComplete: { _ in
                            self.hideProgress()
                        })
    }

    private func handleLaunchDetailsByApiResult(model: LaunchesResponse) {
        imgBanner.downloadImage(imageUrl: model.rocket?.imageUrl ?? "")
        if let missionName = model.mission_name {
            labelBannerTitle.isHidden = false
            labelBannerTitle.text = missionName
        } else {
            labelBannerTitle.isHidden = true
        }

        self.labelLaunchTitle.text = model.mission_name ?? ""

        let rocketName = model.rocket?.rocket_name ?? ""
        let rocketType = model.rocket?.rocket_type ?? ""
        self.labelLaunchDescription.text = "\(rocketName) - \(rocketType)"

        if let launchDate = model.getDateLaunchDate() {
            labelLaunchDate.text = launchDate.toString(format: "dd.MM.yyyy")
        }
    }

}
