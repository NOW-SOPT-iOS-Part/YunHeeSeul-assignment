//
//  DailyBoxOfficeCell.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/10/24.
//

import UIKit

class DailyBoxOfficeCell: UICollectionViewCell {
        
    // MARK: - UI Properties
           
    let rankingLabel: UILabel = UILabel()
    
    let movieInfoStackView: UIStackView = UIStackView()
    
    let titleLabel: UILabel = UILabel()
    
    let audiCntLabel: UILabel = UILabel()
    
    let openDateLabel: UILabel = UILabel()
    
    
    // MARK: - Properties
    
    static let identifier: String = "DailyBoxOfficeCell"
        
    
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
    
    func setCell(contents: DailyBoxOfficeList) {
        rankingLabel.text = contents.rank
        titleLabel.text = contents.movieNm
        audiCntLabel.text = "누적 관객 수 \(contents.audiCnt)명"
        
        let date = contents.openDt.split(separator: "-").map{ String($0) }
        openDateLabel.text = "\(date[0])년 \(date[1])월 \(date[2])일"
    }

 }


 // MARK: - Private Methods

 private extension DailyBoxOfficeCell {
    
    func setHierarchy() {
        
        self.addSubviews(movieInfoStackView, rankingLabel)
        movieInfoStackView.addArrangedSubviews(titleLabel, audiCntLabel, openDateLabel)
        
    }
    
    func setLayout() {
        
        rankingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        movieInfoStackView.snp.makeConstraints {
//            $0.top.equalTo(rankingLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(rankingLabel)
            $0.bottom.equalToSuperview().inset(40)
        }
        
    }
    
    func setStyle() {
        
        self.do {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor(resource: .black)
            $0.layer.borderColor = UIColor(resource: .red).withAlphaComponent(0.3).cgColor
            $0.layer.borderWidth = 2
        }
        
        rankingLabel.do {
            $0.font = UIFont.pretendard(.head1)
            $0.textColor = UIColor(resource: .white)
            $0.textAlignment = .left
        }
        
        movieInfoStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.distribution = .fillProportionally
            $0.spacing = 10
        }
        
        titleLabel.do {
            $0.font = UIFont.pretendard(.subhead6)
            $0.textColor = UIColor(resource: .white)
            $0.textAlignment = .left
            $0.numberOfLines = 0
        }
        
        audiCntLabel.do {
            $0.font = UIFont.pretendard(.subhead2)
            $0.textColor = UIColor(resource: .white)
            $0.textAlignment = .left
        }
     
        openDateLabel.do {
            $0.font = UIFont.pretendard(.subhead2)
            $0.textColor = UIColor(resource: .white)
            $0.textAlignment = .left
        }
    }
    
 }
