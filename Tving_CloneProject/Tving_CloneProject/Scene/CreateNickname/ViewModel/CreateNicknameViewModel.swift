//
//  CreateNicknameViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/4/24.
//

import Foundation

final class CreateNicknameViewModel {
    
    var nickname: ObservablePattern<String> = ObservablePattern.init(nil)
    
    var errMessage: ObservablePattern<String> = ObservablePattern.init(nil)
    
    var isValid: ObservablePattern<Bool> = ObservablePattern.init(false)
    
}

extension CreateNicknameViewModel {
    
    func checkValidNickname(nicknameModel: CreateNicknameModel) {
        guard let nickname = nicknameModel.nickname, !nickname.isEmpty else {
            errMessage.value = "닉네임을 입력해주세요"
            isValid.value = false
            return
        }
        
        // 정규식 패턴
        let pattern = "^[ㄱ-ㅎㅏ-ㅣ가-힣]*$"
        guard let _ = nickname.range(of: pattern, options: .regularExpression) else {
            errMessage.value = "닉네임은 \"한글\"만 사용 가능해요!"
            isValid.value = false
            return
        }
        
        self.nickname.value = nickname
        isValid.value = true
    }
    
    func fetchErrMessage() -> String {
        guard let errMessage = self.errMessage.value else { return "" }
        return errMessage
    }
    
}
