//
//  BasicCell.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/23/24.
//

import UIKit

import SnapKit
import Then

final class ImageWithTitleCell: UICollectionViewCell {
 
    // MARK: - UI Properties
    
    let posterImageView: UIImageView = UIImageView()
    
    let titleLabel: UILabel = UILabel()
    
    
    // MARK: - Properties
    
    static let identifier: String = "ImageWithTitleCell"
        
    
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
        posterImageView.image = contents.image
        titleLabel.text = contents.title
    }

}


// MARK: - Private Methods

private extension ImageWithTitleCell {
    
    func setHierarchy() {
        
        self.addSubviews(posterImageView, titleLabel)
        
    }
    
    func setLayout() {
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
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
