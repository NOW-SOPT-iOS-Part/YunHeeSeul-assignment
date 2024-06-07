//
//  CreateNicknameViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/4/24.
//

import RxSwift
import RxRelay

final class CreateNicknameViewModel {
    
    var nickname: String?
        
    struct Input {
        
        let nicknameTextfieldDidChangeEvent: Observable<String?>
        
    }
    
    struct Output {
        
        var isValid = PublishRelay<Bool>()
        
        var nicknameEmpty = PublishRelay<Bool>()

        var errMessage = PublishRelay<String>()
        
    }
    
}

extension CreateNicknameViewModel {
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.nicknameTextfieldDidChangeEvent.subscribe(onNext: { [weak self] nickname in
            self?.nickname = nickname
            let nickname = self?.nickname ?? ""
            if  !nickname.isEmpty {
                output.isValid.accept(true)
            } else {
                output.errMessage.accept("닉네임을 입력해주세요")
                output.isValid.accept(false)
            }
            
            // 정규식 패턴
            let pattern = "^[ㄱ-ㅎㅏ-ㅣ가-힣]*$"
            guard let _ = nickname.range(of: pattern, options: .regularExpression) else {
                output.errMessage.accept("닉네임은 \"한글\"만 사용 가능해요!")
                output.isValid.accept(false)
                return
            }
            output.isValid.accept(true)

        }).disposed(by: disposeBag)
        
        return output
    }
    
}
