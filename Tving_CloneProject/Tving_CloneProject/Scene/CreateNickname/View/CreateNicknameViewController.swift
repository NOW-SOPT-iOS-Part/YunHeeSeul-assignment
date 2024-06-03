//
//  CreateNicknameViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/10/24.
//

import UIKit

protocol CreateNicknameVCDelegate: AnyObject {
    func saveUserNickname(nickname: String)
}

final class CreateNicknameViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let createNicknameView = CreateNicknameView()
    
    
    // MARK: - Properties
    
    var isActivate: Bool = false
    
    weak var delegate: CreateNicknameVCDelegate?
    
    private let createNicknameViewModel = CreateNicknameViewModel()
    
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = createNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setCreateNicknameView()
    }

}


// MARK: - Private Methods

private extension CreateNicknameViewController {
    
    func setStyle() {
        self.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setCreateNicknameView() {
        createNicknameView.do {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDimmedView))
            $0.dimmedView.isUserInteractionEnabled = true
            $0.dimmedView.addGestureRecognizer(gesture)
            $0.nicknameTextField.delegate = self
            $0.nicknameTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
            $0.saveButton.addTarget(self, action: #selector(popToLoginVC), for: .touchUpInside)
        }
    }
    
    @objc
    func textFieldChange() {
        isActivate = createNicknameViewModel.checkValidNickname(
            nicknameModel: CreateNicknameModel(nickname: self.createNicknameView.nicknameTextField.text))
        createNicknameView.setSaveButton(isEnabled: isActivate)
    }
    
    @objc
    func popToLoginVC() {
        if isActivate {
            let nickname = self.createNicknameView.nicknameTextField.text ?? ""
            self.delegate?.saveUserNickname(nickname: nickname)
            self.dismiss(animated: true)
        }
    }
    
    @objc
    func didTapDimmedView(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
}

// MARK: - Delegates

extension CreateNicknameViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 입력된 문자열이 패턴과 일치하는지 확인
        if createNicknameViewModel.checkValidNickname(
            nicknameModel: CreateNicknameModel(nickname: textField.text)) {
            self.createNicknameView.warningLabel.isHidden = true
            return true
        } else {
            self.createNicknameView.warningLabel.isHidden = false
            self.createNicknameView.warningLabel.text = createNicknameViewModel.fetchErrMessage()
            self.isActivate = false
            self.createNicknameView.setSaveButton(isEnabled: false)
            return false
        }
    }
}
