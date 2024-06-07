//
//  WelcomeViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/4/24.
//

import Foundation

final class WelcomeViewModel {
    
    // MARK: - Properties

    var nickname: ObservablePattern<String> = ObservablePattern.init(nil)
    
}

extension WelcomeViewModel {
    
    func checkNotEmptyNickname(nickname: String?) -> Bool {
        guard let nickname else { return false }
        self.nickname.value = nickname
        return true
    }
    
    func fetchNickname() -> String {
        guard let nickname = self.nickname.value else { return "" }
        return nickname
    }
    
}
