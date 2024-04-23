//
//  BasicCell.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/23/24.
//

import UIKit

import SnapKit
import Then

final class BasicCell: UICollectionViewCell {
    
    enum CellTypes {
        case imageOnly(Contents)
        case imageNTitle(Contents)
        case popularLiveChannel(Contents)
    }
 
    // MARK: - UI Properties
    
    let posterImageView: UIImageView = UIImageView()
    
    let titleLabel: UILabel = UILabel()
    
    let rankingLabel: UILabel = UILabel()
    
    let channelInfoStackView: UIStackView = UIStackView()
    
    let channelLabel: UILabel = UILabel()
    
    let programTitleLabel: UILabel = UILabel()
    
    let ratingLabel: UILabel = UILabel()
    
    
    // MARK: - Properties
    
    static let identifier: String = "BasicCell"
        
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setStyle()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellByType(types: CellTypes) {

        switch types {
        case .imageOnly(let contents):
            self.addSubview(posterImageView)
            
            posterImageView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            posterImageView.image = contents.image
            
            
        case .imageNTitle(let contents):
            self.addSubviews(posterImageView, titleLabel)
            
            posterImageView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(ScreenUtils.getHeight(146))
            }
            titleLabel.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(posterImageView.snp.bottom).offset(3)
            }
            
            posterImageView.image = contents.image
            titleLabel.text = contents.title
            
        case .popularLiveChannel(let contents):
            self.addSubviews(posterImageView, rankingLabel, channelInfoStackView)
            channelInfoStackView.addArrangedSubviews(channelLabel, programTitleLabel, ratingLabel)
            
            posterImageView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(ScreenUtils.getHeight(80))
            }
            rankingLabel.snp.makeConstraints {
                $0.leading.equalTo(posterImageView).inset(6)
                $0.top.equalTo(posterImageView.snp.bottom).offset(11)
            }
            channelInfoStackView.snp.makeConstraints {
                $0.leading.equalTo(rankingLabel.snp.trailing).offset(4)
                $0.top.equalTo(posterImageView.snp.bottom).offset(11)
                $0.height.equalTo(48)
            }
            
            posterImageView.image = contents.image
            let ranking = contents.ranking ?? 0
            rankingLabel.text = "\(ranking)"
            channelLabel.text = contents.channelName
            programTitleLabel.text = contents.title
            let rating = contents.rating ?? 0.0
            ratingLabel.text = "\(rating)%"
            
        }
    }
    
}

// MARK: - Private Methods

private extension BasicCell {

    func setStyle() {
        
        posterImageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 3
            $0.backgroundColor = UIColor(resource: .grey4)
        }
        
        titleLabel.do {
            $0.font = UIFont.pretendard(.body3)
            $0.textColor = UIColor(resource: .grey2)
            $0.textAlignment = .left
        }
        
        rankingLabel.do {
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(.subhead6)
            $0.textColor = UIColor(resource: .white)
        }
        
        channelInfoStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.distribution = .fillEqually
        }
        
        channelLabel.do {
            $0.font = UIFont.pretendard(.body3)
            $0.textColor = UIColor(resource: .white)
            $0.textAlignment = .left
        }
        
        programTitleLabel.do {
            $0.font = UIFont.pretendard(.body3)
            $0.textColor = UIColor(resource: .grey2)
            $0.textAlignment = .left
        }
        
        ratingLabel.do {
            $0.font = UIFont.pretendard(.body3)
            $0.textColor = UIColor(resource: .grey2)
            $0.textAlignment = .left
        }
        
        
    }
    
}
