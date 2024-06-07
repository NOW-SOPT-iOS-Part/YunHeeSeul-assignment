//
//  TextfieldStatus.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/7/24.
//

import UIKit

protocol TextfieldStatus {
    
    var bgColor: UIColor { get }
    
    var borderColor: UIColor { get }
    
    var borderWidth: CGFloat { get }

    var borderRadius: CGFloat { get }
    
}

extension TextfieldStatus {
    
    var borderWidth: CGFloat { return 0 }
    
    var borderRadius: CGFloat { return 3 }
}

struct UnselectedTextfield: TextfieldStatus {
    
    var bgColor: UIColor = UIColor(resource: .grey4)
    
    var borderColor: UIColor = UIColor(resource: .grey4)
        
}

struct SelectedTextfield: TextfieldStatus {
    
    var bgColor: UIColor = UIColor(resource: .grey4)
    
    var borderColor: UIColor = UIColor(resource: .grey2)
        
    var borderWidth: CGFloat = 1

}

struct CreateNicknameTextfield: TextfieldStatus {
    
    var bgColor: UIColor = UIColor(resource: .grey2)
    
    var borderColor: UIColor = UIColor(resource: .grey2)
        
}
