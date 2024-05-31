//
//  BasicHeaderView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/23/24.
//

import UIKit

import SnapKit
import Then

final class BasicHeaderView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    let titleLabel: UILabel = UILabel()
    
    let viewAllButton: UIButton = UIButton()
    
    
    // MARK: - Properties
    
    static let elementKinds: String = "header"

    static let identifier: String = "BasicHeaderView"

    
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
    
    func bindTitle(headerTitle: String) {
        self.titleLabel.text = headerTitle
    }
    
}


// MARK: - Private Methods

private extension BasicHeaderView {
    
    func setHierarchy() {
        self.addSubviews(titleLabel, viewAllButton)
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        viewAllButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(15)
        }
        
    }
    
    func setStyle() {
        titleLabel.do {
            $0.font = UIFont.pretendard(.subhead3)
            $0.textColor = UIColor(resource: .white)
        }
        
        viewAllButton.do {
            $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            $0.imageView?.tintColor = UIColor(resource: .grey2)
            $0.setTitle("전체보기", for: .normal)
            $0.titleLabel?.font = UIFont.pretendard(.subhead5)
            $0.setTitleColor(UIColor(resource: .grey2), for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
        }
        
    }
    
}
