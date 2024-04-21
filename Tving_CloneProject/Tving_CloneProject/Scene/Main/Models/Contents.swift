//
//  Contents.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/22/24.
//

import UIKit

struct Contents {
    let image: UIImage
    let title: String
}

extension Contents {
    
    static func mainPoster() -> [Contents] {
        return [Contents(image: .poster1, title: ""),
                Contents(image: .poster2, title: ""),
                Contents(image: .poster3, title: ""),
                Contents(image: .poster4, title: ""),
                Contents(image: .poster5, title: "")]
    }
    
    static func recommended() -> [Contents] {
        return [Contents(image: .poster1, title: "눈물의 여왕"),
                Contents(image: .poster2, title: "환승연애3"),
                Contents(image: .poster3, title: "선재 업고 튀어"),
                Contents(image: .poster4, title: "너의 이름은"),
                Contents(image: .poster5, title: "해리포터와 마법사의 돌")]
    }
    
    static func paramounts() -> [Contents] {
        return [Contents(image: .poster1, title: "눈물의 여왕"),
                Contents(image: .poster2, title: "환승연애3"),
                Contents(image: .poster3, title: "선재 업고 튀어"),
                Contents(image: .poster4, title: "너의 이름은"),
                Contents(image: .poster5, title: "해리포터와 마법사의 돌")]
    }
    
    static func romance() -> [Contents] {
        return [Contents(image: .poster1, title: "눈물의 여왕"),
                Contents(image: .poster2, title: "환승연애3"),
                Contents(image: .poster3, title: "선재 업고 튀어"),
                Contents(image: .poster4, title: "너의 이름은"),
                Contents(image: .poster5, title: "해리포터와 마법사의 돌")]
    }
    
    static func comedy() -> [Contents] {
        return [Contents(image: .poster1, title: "눈물의 여왕"),
                Contents(image: .poster2, title: "환승연애3"),
                Contents(image: .poster3, title: "선재 업고 튀어"),
                Contents(image: .poster4, title: "너의 이름은"),
                Contents(image: .poster5, title: "해리포터와 마법사의 돌")]
    }

}
