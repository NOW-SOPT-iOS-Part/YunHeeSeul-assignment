//
//  LoginViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/28/24.
//

import UIKit

final class LoginViewModel {
    
    // MARK: - Properties
    
    var id: ObservablePattern<String> = ObservablePattern<String>.init(nil)

    var pw: ObservablePattern<String> = ObservablePattern<String>.init(nil)
    
    var nickname: ObservablePattern<String> = ObservablePattern<String>.init(nil)

    var errMessage: ObservablePattern<String> = ObservablePattern<String>.init(nil)

}

extension LoginViewModel {
    
    func checkEmptyNickname(nickname: String?) -> Bool {
        guard let nickname else {
            errMessage.value = "닉네임을 입력해주세요"
            return false
        }
        
        self.nickname.value = nickname
        return true
    }
    
    func checkValidNickname(nickname: String?) -> Bool {
        guard let nickname else {
            errMessage.value = "닉네임을 입력해주세요"
            return false
        }
        
        // 정규식 패턴
        let pattern = "^[ㄱ-ㅎㅏ-ㅣ가-힣]*$"
        guard let _ = nickname.range(of: pattern, options: .regularExpression) else {
            errMessage.value = "닉네임은 \"한글\"만 사용 가능해요!"
            return false
        }
        
        self.nickname.value = nickname
        return true
    }
    
    func checkValid(loginInfo: LoginModel) -> Bool {
        guard let id = loginInfo.id else { return false }
        self.id.value = id
        
        guard let pw = loginInfo.pw else { return false }
        self.pw.value = pw
    
        return true
    }
    
    func clearText(textfield: UITextField)  {
        textfield.text = ""
    }
    
    func fetchErrMessage() -> String? {
        return self.errMessage.value
    }
}
