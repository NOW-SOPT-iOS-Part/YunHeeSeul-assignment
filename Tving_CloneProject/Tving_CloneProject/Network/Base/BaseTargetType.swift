//
//  BaseTargetType.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/6/24.
//

import Foundation

import Moya

enum BaseTargetType: TargetType {
    case mainMovie(date: String)
}

extension BaseTargetType {
    
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .mainMovie:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .mainMovie:
            return .get
        }
    }
    
    var parameter: [String : Any]? {
        switch self {
        case .mainMovie(let date):
            return ["key" : Config.movieAPIKey , "targetDt" : date]
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .mainMovie:
            if let parameter = parameter {
                return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            } else {
                return .requestPlain
            }
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type": "application/json"]
        return header
    }
}


