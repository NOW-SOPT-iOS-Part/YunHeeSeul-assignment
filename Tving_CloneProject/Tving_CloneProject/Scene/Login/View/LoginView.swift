//
//  LoginView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/11/24.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func pushToWelcomeVC(id: String)
}

class LoginView: UIView {

    // MARK: - UI Properties
    
    private lazy var idTextField = UITextField()
    
    private lazy var pwTextField = UITextField()
    
    private let loginButton = UIButton()
    
    private let idButtonBox = UIView()
    
    private let pwButtonBox = UIView()
    
    private lazy var idClearButton = UIButton()
    
    private lazy var pwClearButton = UIButton()
    
    private lazy var maskButton =  UIButton()
    
    
    // MARK: - Properties
    
    var isActivate: Bool = false
    
    weak var delegate: LoginViewDelegate?
    
    private let loginViewModel: LoginViewModel = LoginViewModel()
    
    
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
            
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
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
            
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        }
        
        loginButton.do {
            $0.setTitle("로그인하기", for: .normal)
            $0.setTitleColor(UIColor(resource: .grey2), for: .normal)
            $0.layer.cornerRadius = 3
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(resource: .grey4).cgColor
            $0.addTarget(self, action: #selector(pushToWelcomeVC), for: .touchUpInside)
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
    
    func setLoginButton(isEnabled: Bool) {
        if isEnabled {
            loginButton.backgroundColor = UIColor(resource: .red)
            loginButton.setTitleColor(UIColor(resource: .white), for: .normal)
            loginButton.layer.borderWidth = 0
            loginButton.isEnabled = true
            isActivate = true
        } else {
            loginButton.backgroundColor = UIColor(resource: .black)
            loginButton.setTitleColor(UIColor(resource: .grey2), for: .normal)
            loginButton.layer.borderWidth = 1
            loginButton.isEnabled = false
            isActivate = false
        }
    }
    
    @objc
    func textFieldChange() {
        let id = self.idTextField.text
        let pw = self.pwTextField.text
        
        if loginViewModel.checkId(id: id) {
            idClearButton.isHidden = false
        } else {
            pwClearButton.isHidden = false
            maskButton.isHidden = false
        }
        
        setLoginButton(isEnabled: loginViewModel.checkValid(id: id, pw: pw))
    }
    
    @objc
    func maskButtonTapped() {
        self.pwTextField.isSecureTextEntry = !self.pwTextField.isSecureTextEntry
    }
    
    @objc
    func clearButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            self.loginViewModel.clearText(textfield: self.idTextField)
        } else {
            self.loginViewModel.clearText(textfield: self.pwTextField)
        }
        setLoginButton(isEnabled: false)
    }
    
    @objc
    func pushToWelcomeVC() {
        if isActivate {
            let id = self.idTextField.text ?? ""
            self.delegate?.pushToWelcomeVC(id: id)
        }
    }
    
}

// MARK: - Delegates

extension LoginView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing (_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(resource: .grey2).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
}
