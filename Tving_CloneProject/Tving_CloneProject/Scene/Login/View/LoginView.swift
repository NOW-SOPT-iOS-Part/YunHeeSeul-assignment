//
//  LoginView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/11/24.
//

import UIKit

import SnapKit
import Then

final class LoginView: UIView {

    // MARK: - UI Properties
    
    let idTextField = UITextField()
    
    let pwTextField = UITextField()
    
    let loginButton = UIButton()
    
    private let idButtonBox = UIView()
    
    private let pwButtonBox = UIView()
    
    let idClearButton = UIButton()
    
    let pwClearButton = UIButton()
    
    let maskButton =  UIButton()
    
    
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
    
    func setLoginButton(isEnabled: Bool) {
        if isEnabled {
            loginButton.backgroundColor = UIColor(resource: .red)
            loginButton.setTitleColor(UIColor(resource: .white), for: .normal)
            loginButton.layer.borderWidth = 0
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = UIColor(resource: .black)
            loginButton.setTitleColor(UIColor(resource: .grey2), for: .normal)
            loginButton.layer.borderWidth = 1
            loginButton.isEnabled = false
        }
    }
    
}


// MARK: - Private Methods

private extension LoginView {
    
    func setHierarchy() {
        self.addSubviews(idTextField, pwTextField, loginButton)
    }
    
    func setLayout() {
        idTextField.snp.makeConstraints {
            $0.top.centerX.width.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(7)
            $0.centerX.width.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(20)
            $0.centerX.width.equalToSuperview()
            $0.height.equalTo(52)
        }
        
    }
    
    func setStyle() {
        self.backgroundColor = UIColor(resource: .black)
        
        idTextField.do {
            $0.setTextField(forBackgroundColor: UIColor(resource: .grey4),
                                    forBorderColor: UIColor(resource: .grey4),
                                    forBorderWidth: 0,
                                    forCornerRadius: 3)
            $0.setPlaceholder(placeholder: "아이디", fontColor: UIColor(resource: .grey2), font: UIFont.pretendard(.subhead3))
            $0.setLeftPadding(amount: 22)
            $0.textColor = UIColor(resource: .grey2)
            
            idButtonBox.addSubview(idClearButton)
            idButtonBox.snp.makeConstraints {
                $0.width.equalTo(40)
                $0.height.equalTo(20)
            }
            idClearButton.snp.makeConstraints {
                $0.top.leading.height.equalToSuperview()
                $0.trailing.equalToSuperview().inset(20)
                $0.size.equalTo(20)
            }
            $0.rightView = idButtonBox
            $0.rightViewMode = .whileEditing
        }
        
        pwTextField.do {
            $0.setTextField(forBackgroundColor: UIColor(resource: .grey4),
                                    forBorderColor: UIColor(resource: .grey4),
                                    forBorderWidth: 0,
                                    forCornerRadius: 3)
            $0.setPlaceholder(placeholder: "비밀번호", fontColor: UIColor(resource: .grey2), font: UIFont.pretendard(.subhead3))
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
                $0.width.equalTo(24)
            }
            pwClearButton.snp.makeConstraints {
                $0.top.height.equalToSuperview()
                $0.trailing.equalToSuperview().inset(56)
                $0.size.equalTo(20)
            }
            $0.rightView = pwButtonBox
            $0.rightViewMode = .whileEditing
        }
        
        loginButton.do {
            $0.setTitle("로그인하기", for: .normal)
            $0.setTitleColor(UIColor(resource: .grey2), for: .normal)
            $0.layer.cornerRadius = 3
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(resource: .grey4).cgColor
        }
        
        idButtonBox.do {
            $0.backgroundColor = UIColor.clear
        }
        
        idClearButton.do {
            $0.setImage(UIImage(resource: .clear), for: .normal)
        }
        
        pwButtonBox.do {
            $0.backgroundColor = UIColor.clear
        }
        
        pwClearButton.do {
            $0.setImage(UIImage(resource: .clear), for: .normal)
        }
        
        maskButton.do {
            $0.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            $0.tintColor = UIColor(resource: .grey3)
        }
        
    }
    
}
