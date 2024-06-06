//
//  File.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/6/24.
//

import UIKit

protocol ButtonStatus {
    
    var bgColor: UIColor { get }
    
    var titleColor: UIColor { get }
    
    var borderWidth: CGFloat { get }
    
    var isEnabled: Bool { get }
    
}

struct EnabledButton: ButtonStatus {
    
    var bgColor: UIColor = UIColor(resource: .red)
    
    var titleColor: UIColor = UIColor(resource: .white)
    
    var borderWidth: CGFloat = 0
    
    var isEnabled: Bool = true
    
}

struct DisabledSaveButton: ButtonStatus {
    
    var bgColor: UIColor = UIColor(resource: .white)
    
    var titleColor: UIColor = UIColor(resource: .grey2)
    
    var borderWidth: CGFloat = 1
    
    var isEnabled: Bool = false
    
}

struct DisabledLoginButton: ButtonStatus {
    
    var bgColor: UIColor = UIColor(resource: .black)
    
    var titleColor: UIColor = UIColor(resource: .grey2)
    
    var borderWidth: CGFloat = 1
    
    var isEnabled: Bool = false
    
}
