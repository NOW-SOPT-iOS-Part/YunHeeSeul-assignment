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
    
    private let idTextField = UITextField()
    
    private let pwTextField = UITextField()
    
    private let loginButton = UIButton()
    
    private let findIdLabel = UILabel()
    
    private let findPwLabel = UILabel()
    
    private let divider = UIView()
    
    private let messageLabel = UILabel()
    
    private let createNicknameLabel = UILabel()
    
    private let idButtonBox = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
    
    private let pwButtonBox = UIView()
    
    private lazy var idClearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    private lazy var pwClearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    private lazy var maskButton =  UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    
    // MARK: - Properties
    
    let width = UIScreen.main.bounds.size.width / 375
    
    let height = UIScreen.main.bounds.size.height / 812
    
    var isActivate: Bool = false

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
                              idTextField, 
                              pwTextField,
                              loginButton,
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
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width * 335)
            $0.height.equalTo(height * 52)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width * 335)
            $0.height.equalTo(height * 52)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width * 335)
            $0.height.equalTo(height * 52)
        }
        
        findIdLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(85)
            $0.width.equalTo(width * 65)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
        
        findPwLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(30)
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
            $0.textColor = UIColor(resource: .white)
        }
        
        idTextField.do {
            $0.setTextField(forBackgroundColor: UIColor(resource: .grey4),
                            forBorderColor: UIColor(resource: .grey4),
                            forBorderWidth: 0,
                            forCornerRadius: 3)
            $0.setPlaceholder(placeholder: "아이디",
                              fontColor: UIColor(resource: .grey2),
                              font: UIFont.pretendard(.subhead3))
            $0.setLeftPadding(amount: 22)
            $0.textColor = UIColor(resource: .grey2)
            
            idButtonBox.addSubview(idClearButton)
            idClearButton.snp.makeConstraints {
                $0.top.leading.height.equalToSuperview()
                $0.trailing.equalToSuperview().inset(20)
            }
            $0.rightView = idButtonBox
            $0.rightViewMode = .whileEditing
            
            $0.delegate = self
        }
        
        pwTextField.do {
            $0.setTextField(forBackgroundColor: UIColor(resource: .grey4),
                            forBorderColor: UIColor(resource: .grey4),
                            forBorderWidth: 0,
                            forCornerRadius: 3)
            $0.setPlaceholder(placeholder: "비밀번호",
                              fontColor: UIColor(resource: .grey2),
                              font: UIFont.pretendard(.subhead3))
            $0.setLeftPadding(amount: 22)
            $0.textColor = UIColor(resource: .grey2)
            $0.isSecureTextEntry = true
            
            pwButtonBox.addSubviews(pwClearButton, maskButton)
            
            pwButtonBox.snp.makeConstraints {
                $0.width.equalTo(80)
                $0.height.equalTo(20)
            }
            maskButton.snp.makeConstraints {
                $0.top.height.equalToSuperview()
                $0.trailing.equalToSuperview().inset(20)
            }
            
            pwClearButton.snp.makeConstraints {
                $0.top.height.equalToSuperview()
                $0.trailing.equalToSuperview().inset(56)
            }
            
            $0.rightView = pwButtonBox
            $0.rightViewMode = .whileEditing
            
            $0.delegate = self
        }
        
        loginButton.do {
            $0.setTitle("로그인하기", for: .normal)
            $0.setTitleColor(UIColor(resource: .grey2), for: .normal)
            $0.layer.cornerRadius = 3
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(resource: .grey4).cgColor
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
        }
        
        idButtonBox.do {
            $0.backgroundColor = UIColor.clear
        }
        
        idClearButton.do {
            $0.setImage(UIImage(resource: .clear), for: .normal)
            $0.tag = 0
            $0.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        }
        
        pwButtonBox.do {
            $0.backgroundColor = UIColor.clear
        }
        
        pwClearButton.do {
            $0.setImage(UIImage(resource: .clear), for: .normal)
            $0.tag = 1
            $0.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        }
        
        maskButton.do {
            $0.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            $0.tintColor = UIColor(resource: .grey3)
            $0.addTarget(self, action: #selector(maskButtonTapped), for: .touchUpInside)
        }
        
    }
    
    @objc
    func maskButtonTapped() {
        self.pwTextField.isSecureTextEntry = !self.pwTextField.isSecureTextEntry
    }
    
    @objc
    func clearButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            self.idTextField.text = ""
        } else {
            self.pwTextField.text = ""
        }
        loginButton.backgroundColor = UIColor(resource: .black)
        loginButton.isEnabled = false
        isActivate = false
    }
    
}

// MARK: - Delegates

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing (_ textField: UITextField) {
        
        if textField.placeholder == "아이디" {
            self.idTextField.layer.borderWidth = 1
            self.idTextField.layer.borderColor = UIColor(resource: .grey2).cgColor
        } else {
            self.pwTextField.layer.borderWidth = 1
            self.pwTextField.layer.borderColor = UIColor(resource: .grey2).cgColor
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.placeholder == "아이디" {
            self.idTextField.layer.borderWidth = 0
            self.idTextField.layer.borderColor = UIColor(resource: .grey4).cgColor
        } else {
            self.pwTextField.layer.borderWidth = 0
            self.pwTextField.layer.borderColor = UIColor(resource: .grey4).cgColor
        }
    }
}
