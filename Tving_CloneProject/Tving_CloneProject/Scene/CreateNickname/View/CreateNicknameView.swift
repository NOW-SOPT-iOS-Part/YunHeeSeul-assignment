//
//  CreateNicknameView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/4/24.
//

import UIKit

import SnapKit
import Then

final class CreateNicknameView: UIView {
    
    // MARK: - UI Properties
    
    let dimmedView = UIView()
    
    private let bottomSheetView = UIView()
    
    private let nicknameLabel = UILabel()
    
    let nicknameTextField = UITextField()
    
    let saveButton = UIButton()
    
    let warningLabel = UILabel()
    
    
    // MARK: - Properties
            
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
    
    func setSaveButton(isEnabled: Bool) {
        if isEnabled {
            saveButton.backgroundColor = UIColor(resource: .red)
            saveButton.setTitleColor(UIColor(resource: .white), for: .normal)
            saveButton.layer.borderWidth = 0
            saveButton.isEnabled = true
        } else {
            saveButton.backgroundColor = UIColor(resource: .white)
            saveButton.setTitleColor(UIColor(resource: .grey2), for: .normal)
            saveButton.layer.borderWidth = 1
            saveButton.isEnabled = false
        }
    }
}


// MARK: - Private Methods

private extension CreateNicknameView {
    
    func setHierarchy() {
        self.addSubviews(dimmedView, bottomSheetView)
        bottomSheetView.addSubviews(nicknameLabel, nicknameTextField, warningLabel, saveButton)
    }
    
    func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomSheetView.snp.top)
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.height.equalTo(406)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview().inset(20)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
    }
    
    func setStyle() {
        dimmedView.do {
            $0.alpha = 0.7
            $0.layer.backgroundColor = UIColor(resource: .black).cgColor
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
            $0.setLeftPadding(amount: 23)
        }
        
        warningLabel.do {
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
        }
    }
}
