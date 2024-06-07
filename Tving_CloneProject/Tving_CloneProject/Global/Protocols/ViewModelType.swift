//
//  ViewModelType.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/7/24.
//

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input, disposeBag: RxSwift.DisposeBag) -> Output
}
