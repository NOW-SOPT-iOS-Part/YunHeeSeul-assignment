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
        
    private let loginView = LoginView()
    
    private let createView = CreateView()
    
    
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
        setView()
    }
    
}


// MARK: - Private Methods

private extension LoginViewController {
    
    func setHierarchy() {
        self.view.addSubviews(loginView, createView)
    }
    
    func setLayout() {
        loginView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
        
        createView.snp.makeConstraints {
            $0.top.equalTo(loginView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func setStyle() {
        self.view.backgroundColor = UIColor(resource: .black)
    }
    
    func setView() {
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
        
        self.createView.do {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(presentCreateNicknameVC))
            $0.createNicknameLabel.isUserInteractionEnabled = true
            $0.createNicknameLabel.addGestureRecognizer(gesture)
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
        loginModel = LoginModel(id: self.loginView.idTextField.text, pw: self.loginView.pwTextField.text)
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
