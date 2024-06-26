//
//  UIFont+.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/9/24.
//

import UIKit

enum FontName {
    case head1
    case subhead1, subhead2, subhead3, subhead4, subhead5, subhead6
    case info12
    case body1, body2, body3
    
    
    var rawValue: String {
        switch self {
        case .head1:
            return "Pretendard-ExtraBold"
        case .subhead1, .subhead6:
            return "Pretendard-Bold"
        case .subhead3, .subhead4:
            return "Pretendard-SemiBold"
        case .subhead2, .subhead5, .info12:
            return "Pretendard-Regular"
        case .body1, .body2, .body3:
            return "Pretendard-Medium"
        }
    }
    
    var size: CGFloat {
        switch self {
        case .head1:
            return 25
        case .body1, .subhead1:
            return 23
        case .subhead6:
            return 19
        case .body2:
            return 17
        case .subhead2:
            return 16
        case .subhead3:
            return 15
        case .subhead4, .subhead5:
            return 14
        case .info12:
            return 12
        case .body3:
            return 10

        }
    }
}

extension UIFont {
    static func pretendard(_ style: FontName) -> UIFont {
        return UIFont(name: style.rawValue, size: style.size)!
    }
}
