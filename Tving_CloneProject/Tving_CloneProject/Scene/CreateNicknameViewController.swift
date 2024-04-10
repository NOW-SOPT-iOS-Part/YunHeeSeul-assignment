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

class CreateNicknameViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let dimmedView = UIView()
    
    private let bottomSheetView = UIView()
    
    private let nicknameLabel = UILabel()
    
    private let nicknameTextField = UITextField()
    
    private let saveButton = UIButton()
    
    private let warningLabel = UILabel()
    
    
    // MARK: - Properties
    
    let width = UIScreen.main.bounds.size.width / 375
    
    let height = UIScreen.main.bounds.size.height / 812
    
    var isActivate: Bool = false
    
    weak var delegate: CreateNicknameVCDelegate?
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setLayout()
        setStyle()
    }
    

}

// MARK: - Private Methods

private extension CreateNicknameViewController {
    
    func setHierarchy() {
        self.view.addSubviews(dimmedView, bottomSheetView)
        bottomSheetView.addSubviews(nicknameLabel, nicknameTextField, warningLabel, saveButton)
    }
    
    func setLayout() {
        
        dimmedView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomSheetView.snp.top)
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.height.equalTo(height * 812 / 2)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview().inset(20)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(height * 52)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(height * 52)
        }

    }
    
    func setStyle() {
        self.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        dimmedView.do {
            $0.alpha = 0.7
            $0.layer.backgroundColor = UIColor(resource: .black).cgColor
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDimmedView))
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(gesture)
        }
        
        bottomSheetView.do {
            $0.backgroundColor = UIColor(resource: .white)
            $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        nicknameLabel.do {
            $0.text = "닉네임을 입력해주세요"
            $0.font = UIFont.pretendard(.body1)
            $0.textColor = UIColor(resource: .black)
            $0.backgroundColor = UIColor(resource: .white)
        }
        
        nicknameTextField.do {
            $0.setTextField(forBackgroundColor: UIColor(resource: .grey2), 
                            forBorderColor: UIColor(resource: .grey2),
                            forBorderWidth: 0,
                            forCornerRadius: 3)
            $0.textColor = UIColor(resource: .grey4)
            $0.delegate = self
            $0.setLeftPadding(amount: 23)
            $0.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        }
        
        warningLabel.do {
            $0.text = "닉네임은 \"한글\"만 사용 가능해요!"
            $0.font = UIFont.pretendard(.subhead5)
            $0.textColor = UIColor(resource: .red)
            $0.isHidden = true
        }
        
        saveButton.do {
            $0.setTitle("저장하기", for: .normal)
            $0.layer.cornerRadius = 12
            $0.backgroundColor = UIColor(resource: .white)
            $0.setTitleColor(UIColor(resource: .grey2), for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(resource: .grey2).cgColor
            $0.addTarget(self, action: #selector(popToLoginVC), for: .touchUpInside)
        }
        
    }
    
    func setSaveButton(isEnabled: Bool) {
        if isEnabled {
            saveButton.backgroundColor = UIColor(resource: .red)
            saveButton.setTitleColor(UIColor(resource: .white), for: .normal)
            saveButton.layer.borderWidth = 0
            saveButton.isEnabled = true
            isActivate = true
        } else {
            saveButton.backgroundColor = UIColor(resource: .white)
            saveButton.setTitleColor(UIColor(resource: .grey2), for: .normal)
            saveButton.layer.borderWidth = 1
            saveButton.isEnabled = false
            isActivate = false
        }
    }
    
    @objc
    func textFieldChange() {
        let nickname = self.nicknameTextField.text ?? ""
        setSaveButton(isEnabled: !nickname.isEmpty)
    }
    
    @objc
    func popToLoginVC() {
        if isActivate {
            let nickname = self.nicknameTextField.text ?? ""
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
        // 정규식 패턴
        let pattern = "^[ㄱ-ㅎㅏ-ㅣ가-힣]*$"
        
        // 입력된 문자열이 패턴과 일치하는지 확인
        if let text = string.range(of: pattern, options: .regularExpression) {
            self.warningLabel.isHidden = true
            return true
        } else {
            self.warningLabel.isHidden = false
            setSaveButton(isEnabled: false)
            return false
        }
    }
}
