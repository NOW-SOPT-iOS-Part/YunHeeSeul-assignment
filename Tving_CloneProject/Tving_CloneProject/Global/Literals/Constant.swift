//
//  Constants.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/11/24.
//

import UIKit

enum Constant {
    struct Screen {
        public static let width = UIScreen.main.bounds.width
        public static let height = UIScreen.main.bounds.height
    }
}

enum MainSection {
    case mainPoster
    case recommendedContents
    case popularLiveChannel
    case paramounts
    case categories
    
    static let dataSource: [MainSection] = [
        MainSection.mainPoster,
        MainSection.recommendedContents,
        MainSection.popularLiveChannel,
        MainSection.paramounts,
        MainSection.categories
    ]
}
