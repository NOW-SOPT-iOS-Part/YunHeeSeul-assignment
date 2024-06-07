//
//  ViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/8/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    // MARK: - UI Properties
        
    private let loginView = LoginView()
    
    private let createView = CreateView()
    
    
    // MARK: - Properties
    
    var isActivate: Bool = false {
        didSet {
            self.loginView.setLoginButton(isEnabled: isActivate)
        }
    }
    
    var nickname: String? = nil
    
    var loginModel: LoginModel = LoginModel(id: nil, pw: nil)
    
    private let loginViewModel: LoginViewModel = LoginViewModel()
    
    private let disposeBag = DisposeBag()
    
    private let selectedTextfieldStatus: TextfieldStatus = SelectedTextfield()

    private let unselectedTextfieldStatus: TextfieldStatus = UnselectedTextfield()
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        setView()
        setViewModel()
        clearButtonTapped()
        pushToWelcomeVC()
        maskButtonTapped()
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
            $0.pwTextField.delegate = self
        }
        
        self.createView.do {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(presentCreateNicknameVC))
            $0.createNicknameLabel.isUserInteractionEnabled = true
            $0.createNicknameLabel.addGestureRecognizer(gesture)
        }
    }
    
    private func setViewModel() {
        let input = LoginViewModel.Input(
            idTextfieldDidChangeEvent: loginView.idTextField.rx.text.asObservable(),
            pwTextfieldDidChangeEvent: loginView.pwTextField.rx.text.asObservable(),
            loginButtonDidTapEvent: loginView.loginButton.rx.tap.asObservable()
        )
        
        let output = loginViewModel.transform(from: input, disposeBag: disposeBag)
        
        output.isValid.subscribe(onNext: { [weak self] isValid in
            self?.isActivate = isValid ? true : false
        }).disposed(by: disposeBag)
    }
    
    @objc
    func presentCreateNicknameVC(sender: UITapGestureRecognizer) {
        let createNicknameVC = CreateNicknameViewController()
        createNicknameVC.delegate = self
        createNicknameVC.modalPresentationStyle = .overFullScreen
        self.present(createNicknameVC, animated: true)
    }
    
    func maskButtonTapped() {
        loginView.maskButton.rx.tap
            .subscribe(
                onNext:  { _ in
                    self.loginView.pwTextField.isSecureTextEntry = !self.loginView.pwTextField.isSecureTextEntry
                }).disposed(by: disposeBag)
    }

    func clearButtonTapped() {
        loginView.idClearButton.rx.tap
            .subscribe(
                onNext:  { _ in
                    self.loginViewModel.clearText(textfield: self.loginView.idTextField)
                }).disposed(by: disposeBag)
        
        loginView.pwClearButton.rx.tap
            .subscribe(
                onNext:  { _ in
                    self.loginViewModel.clearText(textfield: self.loginView.pwTextField)
                }).disposed(by: disposeBag)

        self.isActivate = false
    }

    func pushToWelcomeVC() {
        loginView.loginButton.rx.tap
            .subscribe(
                onNext: { _ in
                    if self.isActivate {
                        let welcomeVC = WelcomeViewController()
                        let nickname = self.loginViewModel.fetchNickname()
                        if nickname.isEmpty {
                            welcomeVC.userInfo = self.loginViewModel.fetchId()
                        } else {
                            welcomeVC.userInfo = nickname
                         }
                        self.navigationController?.pushViewController(welcomeVC, animated: true)
                    }
                }).disposed(by: disposeBag)
    }
}

// MARK: - Delegates

extension LoginViewController: CreateNicknameVCDelegate {
    
    func saveUserNickname(nickname: String) {
        self.loginViewModel.nickname = nickname
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing (_ textField: UITextField) {
        textField.setTextField(textfieldStatus: selectedTextfieldStatus)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setTextField(textfieldStatus: unselectedTextfieldStatus)
    }
}
