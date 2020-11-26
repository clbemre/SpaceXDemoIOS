//
//  HomeSliderCell.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit

class HomeSliderCell: BaseCollectionViewCell {
    
    let contentImageView: UIImageView = {
        return UIImageView()
    }()
    
    let labelContent: PaddingLabel = {
        let label = PaddingLabel(withInsets: 8, 8, 8, 8)
        label.font = FontBook.Roboto.Black.of(size: 32)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        label.textColor = .white
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        return label
    }()
    
    var model: LaunchesResponse! {
        didSet{
            self.updateCellUI()
        }
    }
    
    override func initialeSelf() {
        addViews()
        setupConstraints()
    }
    
    private func updateCellUI() {
        labelContent.text = self.model.mission_name ?? ""
        contentImageView.downloadImage(imageUrl: self.model.rocket?.imageUrl ?? "")
    }

}

// MARK: Setup UI
private extension HomeSliderCell {

    func addViews() {
        addSubview(self.contentImageView)
        addSubview(labelContent)
    }

    func setupConstraints() {
        // Content Image View
        self.contentImageView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        // Content Label
        self.labelContent.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(contentImageView.snp.centerX)
            maker.bottom.equalToSuperview().offset(-60)
            maker.height.equalTo(40)
        }
    }

}
