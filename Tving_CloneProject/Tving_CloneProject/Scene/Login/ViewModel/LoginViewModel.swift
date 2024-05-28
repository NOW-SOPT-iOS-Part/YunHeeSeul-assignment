//
//  LoginViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/28/24.
//

import UIKit

final class LoginViewModel {
    
    // MARK: - Properties
    
    var errMessage: String = ""
}

extension LoginViewModel {
    
    func checkValid(id: String?, pw: String?) -> Bool {
        guard let id else {
            errMessage = "아이디를 입력해주세요"
            return false
        }
        
        guard let pw else {
            errMessage = "비밀번호를 입력해주세요"
            return false
        }
        
        return true
    }
    
    func checkId(id: String?) -> Bool {
        guard let id else {
            return false
        }
        return true
    }
    
    func clearText(textfield: UITextField)  {
        textfield.text = ""
    }
}
