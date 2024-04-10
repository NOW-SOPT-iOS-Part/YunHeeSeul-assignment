//
//  WelcomeViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/10/24.
//

import UIKit

import SnapKit
import Then

class WelcomeViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let logoImageView = UIImageView()
    
    private let welcomeLabel = UILabel()
    
    private lazy var goToMainButton = UIButton()
    
    
    // MARK: - Properties
    
    let width = UIScreen.main.bounds.size.width / 375
    
    let height = UIScreen.main.bounds.size.height / 812
        
    var userInfo: String? = ""
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        bindUserInfo()
    }
    
}


// MARK: - Private Methods

private extension WelcomeViewController {
    
    func setHierarchy() {
        self.view.addSubviews(logoImageView, welcomeLabel, goToMainButton)
    }
    
    func setLayout() {
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(height * 211)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(67)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width * 245)
        }
        
        goToMainButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(66)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width * 335)
            $0.height.equalTo(height * 52)
        }

    }
    
    func setStyle() {
        
        self.view.backgroundColor = UIColor(resource: .black)
        self.navigationController?.navigationBar.isHidden = true
        
        logoImageView.do {
            $0.image = UIImage(resource: .tvingLogo)
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
            $0.addTarget(self, action: #selector(popToLoginVC), for: .touchUpInside)
        }
        
    }
    
    func bindUserInfo() {
        let name = userInfo ?? ""
        self.welcomeLabel.text = "\(name)님\n반가워요!"
    }
    
    @objc
    func popToLoginVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
