//
//  NavigationBarView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/22/24.
//

import UIKit

class NavigationBarView: UIView {
    
    // MARK: - UI Properties
    
    private let tvingLogoButton = UIButton()
    
    private let profileImage = UIImageView()
    
    
    // MARK: - Properties
    
    
    
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

private extension NavigationBarView {
    
    func setHierarchy() {
        
        self.addSubviews(tvingLogoButton, profileImage)
        
    }
    
    func setLayout() {
        
        tvingLogoButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(30)
            $0.trailing.equalToSuperview().inset(10)
        }
        
    }
    
    func setStyle() {
        
        self.backgroundColor = .clear
        
        tvingLogoButton.do {
            $0.setImage(UIImage(resource: .tvingLogo), for: .normal)
        }
        
        profileImage.do {
            $0.image = UIImage(resource: .profileImg)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
        }
        
    }
    
}
