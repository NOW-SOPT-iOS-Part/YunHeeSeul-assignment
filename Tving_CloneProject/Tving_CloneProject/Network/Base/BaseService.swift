//
//  BaseService.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/6/24.
//

import Foundation

class BaseService {
    
    func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        
        switch statusCode {
        case 200..<205:
            return isValidData(data: data, T.self)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }

    }
    
    func isValidData<T: Codable>(data: Data, _ object: T.Type) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("⛔️ \(self)애서 디코딩 오류가 발생했습니다 ⛔️")
            return .decodedErr
        }
        
        return .success(decodedData as Any)
    }
    
}
