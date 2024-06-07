//
//  PagerButtonCell.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/22/24.
//

import UIKit

import SnapKit
import Then

final class PagerButtonCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    let pagerButton = UIButton()
        
    
    // MARK: - Properties
    
    static let identifier: String = "PagerButtonCell"
    
    
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
    
}


// MARK: - Private Methods

private extension PagerButtonCell {
    
    func setHierarchy() {
        self.addSubview(pagerButton)
        
    }
    
    func setLayout() {
        pagerButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func setStyle() {
        pagerButton.do {
            $0.layer.cornerRadius = 2
            $0.backgroundColor = .grey3
            $0.isUserInteractionEnabled = true
        }
        
    }
    
}
