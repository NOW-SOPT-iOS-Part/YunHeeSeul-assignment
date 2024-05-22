//
//  PopularLiveCell.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/25/24.
//

import UIKit

class PopularLiveCell: UICollectionViewCell {

   // MARK: - UI Properties
   
   let posterImageView: UIImageView = UIImageView()
      
   let rankingLabel: UILabel = UILabel()
   
   let channelInfoStackView: UIStackView = UIStackView()
   
   let channelLabel: UILabel = UILabel()
   
   let programTitleLabel: UILabel = UILabel()
   
   let ratingLabel: UILabel = UILabel()
   
   
   // MARK: - Properties
   
   static let identifier: String = "PopularLiveCell"
       
   
   // MARK: - Life Cycles
   
   override init(frame: CGRect) {
       super.init(frame: frame)

       setHierarchy()
       setLayout()
       setStyle()
       
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   func setCell(contents: Contents) {
       
       let ranking = contents.ranking ?? 0
       let rating = contents.rating ?? 0
       
       posterImageView.image = contents.image
       rankingLabel.text = "\(ranking)"
       channelLabel.text = contents.channelName
       programTitleLabel.text = contents.title
       ratingLabel.text = "\(rating)%"
   }

}


// MARK: - Private Methods

private extension PopularLiveCell {
   
   func setHierarchy() {
       
       self.addSubviews(posterImageView, channelInfoStackView, rankingLabel)
       channelInfoStackView.addArrangedSubviews(channelLabel, programTitleLabel, ratingLabel)
       
   }
   
   func setLayout() {
       
       posterImageView.snp.makeConstraints {
           $0.top.leading.trailing.equalToSuperview()
           $0.bottom.equalToSuperview().inset(58)
       }
       
       rankingLabel.snp.makeConstraints {
           $0.top.equalTo(posterImageView.snp.bottom).offset(10)
           $0.leading.equalToSuperview().inset(8)
       }
       
       channelInfoStackView.snp.makeConstraints {
           $0.top.equalTo(posterImageView.snp.bottom).offset(10)
           $0.leading.equalTo(rankingLabel.snp.trailing).offset(8)
           $0.bottom.equalToSuperview()
       }
       
   }
   
   func setStyle() {
       
       posterImageView.do {
           $0.clipsToBounds = true
           $0.layer.cornerRadius = 3
       }
       
       rankingLabel.do {
           $0.font = UIFont.pretendard(.subhead6)
           $0.textColor = UIColor(resource: .white)
           $0.textAlignment = .left
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

