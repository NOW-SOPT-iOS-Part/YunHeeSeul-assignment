//
//  UITextField+.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/9/24.
//

import UIKit

extension UITextField {
    
    func setLeftPadding(amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPadding(amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    //TextField 기본 속성 커스텀
    func setTextField(textfieldStatus: TextfieldStatus) {
        self.clipsToBounds = true
        self.layer.borderColor = textfieldStatus.borderColor.cgColor
        self.layer.borderWidth = textfieldStatus.borderWidth
        self.backgroundColor = textfieldStatus.bgColor
        self.layer.cornerRadius = textfieldStatus.borderRadius
    }
    
    //TextField placeholder 커스텀
    func setPlaceholder(placeholder: String, fontColor: UIColor?, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: fontColor!, .font: font])
    }
}
