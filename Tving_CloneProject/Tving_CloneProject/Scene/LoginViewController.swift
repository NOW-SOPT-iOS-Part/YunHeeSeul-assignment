//
//  ViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/8/24.
//

import UIKit

import SnapKit
import Then

class LoginViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let loginLabel = UILabel()
    
    private let loginView = LoginView()
    
    private let findIdLabel = UILabel()
    
    private let findPwLabel = UILabel()
    
    private let divider = UIView()
    
    private let messageLabel = UILabel()
    
    private let createNicknameLabel = UILabel()
    
    
    // MARK: - Properties
    
    let width = UIScreen.main.bounds.size.width / 375
    
    let height = UIScreen.main.bounds.size.height / 812
    
    var isActivate: Bool = false
    
    var nickname: String = ""
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
}


// MARK: - Private Methods

private extension LoginViewController {
    
    func setHierarchy() {
        self.view.addSubviews(loginLabel,
                              loginView,
                              findIdLabel,
                              findPwLabel,
                              divider,
                              messageLabel,
                              createNicknameLabel)
    }
    
    func setLayout() {
        
        loginLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
        
        loginView.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width * 335)
            $0.height.equalTo(height * 186)
        }
        
        findIdLabel.snp.makeConstraints {
            $0.top.equalTo(loginView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(85)
            $0.width.equalTo(width * 65)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(loginView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
        
        findPwLabel.snp.makeConstraints {
            $0.top.equalTo(loginView.snp.bottom).offset(30)
            $0.leading.equalTo(divider.snp.trailing).offset(35)
            $0.width.equalTo(width * 75)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(findIdLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(51)
        }
        
        createNicknameLabel.snp.makeConstraints {
            $0.top.equalTo(findIdLabel.snp.bottom).offset(28)
            $0.leading.equalTo(findPwLabel)
            $0.width.equalTo(130)
        }
        
    }
    
    func setStyle() {
        
        self.view.backgroundColor = UIColor(resource: .black)
        
        loginLabel.do {
            $0.text = "TVING ID 로그인"
            $0.font = UIFont.pretendard(.body1)
            $0.textColor = UIColor(resource: .grey1)
        }
        
        loginView.do {
            $0.delegate = self
        }
        
        findIdLabel.do {
            $0.text = "아이디 찾기"
            $0.font = UIFont.pretendard(.subhead4)
            $0.textColor = UIColor(resource: .grey2)
        }
        
        divider.do {
            $0.backgroundColor = UIColor(resource: .grey4)
        }
        
        findPwLabel.do {
            $0.text = "비밀번호 찾기"
            $0.font = UIFont.pretendard(.subhead4)
            $0.textColor = UIColor(resource: .grey2)
        }
        
        messageLabel.do {
            $0.text = "아직 계정이 없으신가요?"
            $0.font = UIFont.pretendard(.subhead4)
            $0.textColor = UIColor(resource: .grey3)
        }
        
        createNicknameLabel.do {
            $0.text = "닉네임 만들러가기"
            $0.font = UIFont.pretendard(.subhead4)
            $0.textColor = UIColor(resource: .grey2)
            $0.addUnderline()
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(presentCreateNicknameVC))
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(gesture)
        }
        
    }
    
    @objc
    func presentCreateNicknameVC(sender: UITapGestureRecognizer) {
        let createNicknameVC = CreateNicknameViewController()
        createNicknameVC.delegate = self
        createNicknameVC.modalPresentationStyle = .overFullScreen
        self.present(createNicknameVC, animated: true)
    }
    
}

// MARK: - Delegates

extension LoginViewController: CreateNicknameVCDelegate {
    
    func saveUserNickname(nickname: String) {
        self.nickname = nickname
    }
}

extension LoginViewController: LoginViewDelegate {
    
    func pushToWelcomeVC(id: String) {
        let welcomeVC = WelcomeViewController()
        welcomeVC.userInfo = nickname.isEmpty ? id : nickname
        self.navigationController?.pushViewController(welcomeVC, animated: true)
    }
}
