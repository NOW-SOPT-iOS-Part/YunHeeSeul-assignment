//
//  WelcomeView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/4/24.
//

import UIKit

import SnapKit
import Then

final class WelcomeView: UIView {
    
    // MARK: - UI Properties
    
    private let logoImageView = UIImageView()
    
    let welcomeLabel = UILabel()
    
    let goToMainButton = UIButton()
    
    
    // MARK: - Life Cycle
    
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

private extension WelcomeView {
    
    func setHierarchy() {
        self.addSubviews(logoImageView, welcomeLabel, goToMainButton)
    }
    
    func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(211)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(67)
            $0.leading.trailing.equalToSuperview().inset(65)
        }
        
        goToMainButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(66)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }

    }
    
    func setStyle() {
        logoImageView.do {
            $0.image = UIImage(resource: .redTvingLogo)
        }
        
        welcomeLabel.do {
            $0.font = UIFont.pretendard(.subhead1)
            $0.textColor = UIColor(resource: .grey1)
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        
        goToMainButton.do {
            $0.setTitle("메인으로", for: .normal)
            $0.setTitleColor(UIColor(resource: .white), for: .normal)
            $0.layer.cornerRadius = 3
            $0.backgroundColor = UIColor(resource: .red)
        }
        
    }

}
