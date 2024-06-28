//
//  Observable.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/27/24.
//

import Foundation

class ObservablePattern<T> {

    var value: T? {
        didSet {
            self.listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
       
    private var listener: ((T?) -> Void)? // --- c
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)   
        self.listener = listener
    }
}
