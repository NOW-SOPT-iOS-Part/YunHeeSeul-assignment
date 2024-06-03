//
//  ViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/8/24.
//

import UIKit

import SnapKit
import Then

final class LoginViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let loginLabel = UILabel()
    
    private let loginView = LoginView()
    
    private let findIdLabel = UILabel()
    
    private let findPwLabel = UILabel()
    
    private let divider = UIView()
    
    private let messageLabel = UILabel()
    
    private let createNicknameLabel = UILabel()
    
    
    // MARK: - Properties
    
    var isActivate: Bool = false
    
    var nickname: String? = nil
    
    var loginModel: LoginModel = LoginModel(id: nil, pw: nil)
    
    private let loginViewModel: LoginViewModel = LoginViewModel()
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        setLoginView()
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
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(186)
        }
        
        findIdLabel.snp.makeConstraints {
            $0.top.equalTo(loginView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(85)
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
    
    func setLoginView() {
        self.loginView.do {
            $0.idTextField.delegate = self
            $0.idTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
            $0.pwTextField.delegate = self
            $0.pwTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
            $0.loginButton.addTarget(self, action: #selector(pushToWelcomeVC), for: .touchUpInside)
            $0.idClearButton.tag = 0
            $0.idClearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
            $0.pwClearButton.tag = 1
            $0.pwClearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
            $0.maskButton.addTarget(self, action: #selector(maskButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc
    func presentCreateNicknameVC(sender: UITapGestureRecognizer) {
        let createNicknameVC = CreateNicknameViewController()
        createNicknameVC.delegate = self
        createNicknameVC.modalPresentationStyle = .overFullScreen
        self.present(createNicknameVC, animated: true)
    }
    
    @objc
    func textFieldChange() {
        loginModel = LoginModel(id: self.loginView.idTextField.text, pw: self.loginView.idTextField.text)
        self.isActivate = loginViewModel.checkValid(loginInfo: loginModel)
        self.loginView.setLoginButton(isEnabled: self.isActivate)
    }
    
    @objc
    func maskButtonTapped() {
        self.loginView.pwTextField.isSecureTextEntry = !self.loginView.pwTextField.isSecureTextEntry
    }
    
    @objc
    func clearButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            self.loginViewModel.clearText(textfield: self.loginView.idTextField)
        } else {
            self.loginViewModel.clearText(textfield: self.loginView.pwTextField)
        }
        self.isActivate = false
        self.loginView.setLoginButton(isEnabled: self.isActivate)
    }
    
    @objc
    func pushToWelcomeVC() {
        if isActivate {
            let welcomeVC = WelcomeViewController()
            if loginViewModel.checkEmptyNickname(nickname: self.nickname) {
                welcomeVC.userInfo = self.loginViewModel.id.value
            } else {
                welcomeVC.userInfo = self.loginViewModel.nickname.value
             }
            self.navigationController?.pushViewController(welcomeVC, animated: true)
        }
    }
    
}

// MARK: - Delegates

extension LoginViewController: CreateNicknameVCDelegate {
    
    func saveUserNickname(nickname: String) {
        self.nickname = nickname
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing (_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(resource: .grey2).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
}
