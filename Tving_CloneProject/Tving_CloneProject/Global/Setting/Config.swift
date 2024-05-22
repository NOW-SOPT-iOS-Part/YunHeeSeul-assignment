//
//  Config.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/6/24.
//

import Foundation

enum Config {

    enum Keys {
        enum Plist {
            static let movieAPIKey = "KEY"
            static let baseURL = "BASE_URL"
        }
    }

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found !!!")
        }
        return dict
    }()
}


extension Config {
    static let movieAPIKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.movieAPIKey] as? String else {
            fatalError("KAKAO_NATIVE_APP_KEY is not set in plist for this configuration")
        }
        return key
    }()

    static let baseURL: String = {
        guard let key = Config.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("BASE_URL is not set in plist for this configuration")
        }
        return key
    }()
}
