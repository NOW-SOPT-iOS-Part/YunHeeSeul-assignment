//
//  UIButton+.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/6/24.
//

import UIKit

extension UIButton {
    
    func setButtonStatus(buttonStatus: ButtonStatus) {
        self.backgroundColor = buttonStatus.bgColor
        self.setTitleColor(buttonStatus.titleColor, for: .normal)
        self.layer.borderWidth = buttonStatus.borderWidth
        self.isEnabled = buttonStatus.isEnabled
        self.isSelected = buttonStatus.isSelected
    }
    
}
