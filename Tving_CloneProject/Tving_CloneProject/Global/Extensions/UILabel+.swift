//
//  UILabel+.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/9/24.
//

import UIKit

extension UILabel {
    
    func addUnderline() {
        guard let textString = self.text else { return }

        let attributedString = NSMutableAttributedString(string: textString)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }
}
