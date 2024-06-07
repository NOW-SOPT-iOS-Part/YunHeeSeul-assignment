//
//  LoginViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/28/24.
//

import UIKit

import RxSwift
import RxRelay

final class LoginViewModel {
    
    // MARK: - Properties
    
    private var id: String?
    
    private var pw: String?
    
    var nickname: String?
    
    struct Input {
        
        let idTextfieldDidChangeEvent: Observable<String?>
        
        let pwTextfieldDidChangeEvent: Observable<String?>
        
        let loginButtonDidTapEvent: Observable<Void>

    }
    
    struct Output {
        
        var isValid = PublishRelay<Bool>()
        
        var nicknameEmpty = PublishRelay<Bool>()

        var idEmpty = PublishRelay<Bool>()
        
        var pwEmpty = PublishRelay<Bool>()
        
    }

}

extension LoginViewModel {
    
    func transform(from input: Input, disposeBag: DisposeBag) -> Output {
            let output = Output()
            
            input.idTextfieldDidChangeEvent.subscribe(onNext: { [weak self] id in
                self?.id = id
                let id = self?.id ?? ""
                let pw = self?.pw ?? ""
                if !id.isEmpty && !pw.isEmpty {
                    output.isValid.accept(true)
                } else {
                    output.isValid.accept(false)
                }
            }).disposed(by: disposeBag)
            
            input.pwTextfieldDidChangeEvent.subscribe(onNext: { [weak self] pw in
                self?.pw = pw
                let id = self?.id ?? ""
                let pw = self?.pw ?? ""
                if !id.isEmpty && !pw.isEmpty {
                    output.isValid.accept(true)
                } else {
                    output.isValid.accept(false)
                }
            }).disposed(by: disposeBag)
            
            input.loginButtonDidTapEvent.subscribe(onNext: { [weak self] _ in
                guard let nickname = self?.nickname, !nickname.isEmpty else {
                    output.nicknameEmpty.accept(true)
                    return
                }
                output.nicknameEmpty.accept(false)
                
                guard let id = self?.id, !id.isEmpty else {
                    output.isValid.accept(false)
                    return
                }
                
                guard let pw = self?.pw, !pw.isEmpty else {
                    output.isValid.accept(false)
                    return
                }
                            
                output.isValid.accept(true)
            }).disposed(by: disposeBag)
            
            return output
        }
    
    func clearText(textfield: UITextField)  {
        textfield.text = ""
    }
    
    func fetchId() -> String {
        guard let id = self.id else  { return "" }
        return id
    }
    
    func fetchNickname() -> String {
        guard let nickname = self.nickname else  { return "" }
        return nickname
    }
}
