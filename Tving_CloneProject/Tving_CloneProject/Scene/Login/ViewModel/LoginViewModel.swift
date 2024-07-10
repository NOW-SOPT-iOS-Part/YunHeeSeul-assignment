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

}

extension LoginViewModel {
    
    func checkEmptyNickname(nickname: String?) -> Bool {
        guard let nickname else { return true }
        self.nickname.value = nickname
        return false
    }
    
    func checkValid(loginInfo: LoginModel) -> Bool {
        guard let id = loginInfo.id, !id.isEmpty else { return false }
        self.id.value = id
        
        guard let pw = loginInfo.pw, !pw.isEmpty else { return false }
        self.pw.value = pw
    
        return true
    }
    
    func clearText(textfield: UITextField)  {
        textfield.text = ""
    }

}
