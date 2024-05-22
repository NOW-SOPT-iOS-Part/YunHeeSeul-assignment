//
//  MainService.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/6/24.
//

import Foundation

import Moya

final class MainService {
    
    static let shared = MainService()
    
    private var mainProvider = MoyaProvider<BaseTargetType>(plugins: [MoyaLoggingPlugin()])
    
    private init() {}
}

extension MainService {
    
    func getMovieList(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        mainProvider.request(.mainMovie(date: date)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, GetMovieResponseModel.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
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
