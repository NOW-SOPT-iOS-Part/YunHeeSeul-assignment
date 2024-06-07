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
    
    var isSelected: Bool { get }
    
}

extension ButtonStatus {
    
    var bgColor: UIColor { return UIColor(resource: .white) }

    var borderWidth: CGFloat { return 0 }
    
    var titleColor: UIColor { return UIColor(resource: .grey2) }
    
    var isEnabled: Bool { return false }
    
    var isSelected: Bool { return false }
    
}

struct EnabledButton: ButtonStatus {
    
    var bgColor: UIColor = UIColor(resource: .red)
    
    var titleColor: UIColor = UIColor(resource: .white)
        
    var isEnabled: Bool = true
    
}

struct DisabledSaveButton: ButtonStatus {
            
    var borderWidth: CGFloat = 1
        
}

struct DisabledLoginButton: ButtonStatus {
    
    var bgColor: UIColor = UIColor(resource: .black)
        
    var borderWidth: CGFloat = 1
        
}

struct SelectedPageControlButton: ButtonStatus {
        
    var isSelected: Bool = true
    
    var isEnabled: Bool = true
    
}

struct NotSelectedPageControlButton: ButtonStatus {
    
    var bgColor: UIColor = UIColor(resource: .grey3)
    
    var isSelected: Bool = false
    
    var isEnabled: Bool = true

}
