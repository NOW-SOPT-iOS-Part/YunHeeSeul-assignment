//
//  CreateView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/4/24.
//

import UIKit

import SnapKit
import Then

final class CreateView: UIView {
    
    // MARK: - UI Properties

    private let findIdLabel = UILabel()
    
    private let findPwLabel = UILabel()
    
    private let divider = UIView()
    
    private let messageLabel = UILabel()
    
    let createNicknameLabel = UILabel()

    
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

private extension CreateView {
    
    func setHierarchy() {
        self.addSubviews(findIdLabel,
                              findPwLabel,
                              divider,
                              messageLabel,
                              createNicknameLabel)
    }
    
    func setLayout() {
        findIdLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(85)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }
        
        findPwLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
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
        self.backgroundColor = UIColor(resource: .black)
        
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
    }
}
