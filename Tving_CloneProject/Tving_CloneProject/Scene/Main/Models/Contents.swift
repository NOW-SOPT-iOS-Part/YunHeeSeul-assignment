//
//  Contents.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/22/24.
//

import UIKit

struct Contents {
    let image: UIImage
    var title: String? = ""
    var ranking: Int? = 0
    var channelName: String? = ""
    var rating: Float? = 0.0
}

extension Contents {
    
    static func mainPoster() -> [Contents] {
        return [Contents(image: .poster1),
                Contents(image: .poster2),
                Contents(image: .poster3),
                Contents(image: .poster4),
                Contents(image: .poster5)]
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

    static func popularChannel() -> [Contents] {
        return [Contents(image: .poster1, title: "눈물의 여왕", ranking: 1, channelName: "tvN", rating: 24.2),
                Contents(image: .poster2, title: "환승연애3", ranking: 2, channelName: "tvN", rating: 24.2),
                Contents(image: .poster3, title: "선재 업고 튀어", ranking: 3, channelName: "tvN", rating: 24.2),
                Contents(image: .poster4, title: "너의 이름은", ranking: 4, channelName: "OCN", rating: 24.2),
                Contents(image: .poster5, title: "해리포터와 마법사의 돌", ranking: 5, channelName: "OCN Movies", rating: 24.2)]
    }
}
