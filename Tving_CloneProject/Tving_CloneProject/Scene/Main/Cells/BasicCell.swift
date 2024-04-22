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
 
    // MARK: - UI Properties
    
    let posterImageView: UIImageView = UIImageView()
    
    let titleLabel: UILabel = UILabel()
    
    
    // MARK: - Properties
    
    static let identifier: String = "BasicCell"
    
    
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
    
    func setData(data: Contents) {
        
        posterImageView.image = data.image
        titleLabel.text = data.title
                    
    }
    
}

// MARK: - Private Methods

private extension BasicCell {
    
    func setHierarchy() {
        
        self.addSubviews(posterImageView, titleLabel)
        
    }
    
    func setLayout() {
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(ScreenUtils.getHeight(146))
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(posterImageView.snp.bottom).offset(3)
        }
        
    }
    
    func setStyle() {
        
        posterImageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 3
        }
        
        titleLabel.do {
            $0.font = UIFont.pretendard(.body3)
            $0.textColor = UIColor(resource: .grey2)
            $0.textAlignment = .left
        }
        
    }
    
}
