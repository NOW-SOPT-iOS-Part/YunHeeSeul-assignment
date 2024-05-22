//
//  MainTargetType.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/6/24.
//

import Foundation

import Moya

enum MainTargetType {
    case getMovieList(date: String)
}

extension MainTargetType: BaseTargetType {
    
    var utilPath: String {
        return 
    }
    
    var path: String {
        <#code#>
    }
    
    var task: Moya.Task {
        <#code#>
    }
    
    
}
