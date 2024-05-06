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
    var ranking: String? = ""
    var channelName: String? = ""
    var rating: String? = ""
}

extension Contents {
    
    static let posterImages: [UIImage] = [UIImage(resource: .poster1),
                                          UIImage(resource: .poster2),
                                          UIImage(resource: .poster3),
                                          UIImage(resource: .poster4),
                                          UIImage(resource: .poster5),
                                          UIImage(resource: .category1),
                                          UIImage(resource: .category2),
                                          UIImage(resource: .category3),
                                          UIImage(resource: .category4),
                                          UIImage(resource: .category5)]
    
    static let categoryImages: [UIImage] = [UIImage(resource: .category1),
                                            UIImage(resource: .category2),
                                            UIImage(resource: .category3),
                                            UIImage(resource: .category4),
                                            UIImage(resource: .category5),
                                            UIImage(resource: .poster1),
                                            UIImage(resource: .poster2),
                                            UIImage(resource: .poster3),
                                            UIImage(resource: .poster4),
                                            UIImage(resource: .poster5)]
}
