//
//  MovieViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/31/24.
//

import Foundation

final class MovieViewModel {
    
    // MARK: - Properties
    
    private var dailyBoxOfficeData: ObservablePattern<[DailyBoxOfficeList]> = ObservablePattern([])
    
    var didUpdateNetworkResult: ObservablePattern<Bool> = ObservablePattern(false)
    
    var didChangeLoadingIndicator: ObservablePattern<Bool> = ObservablePattern(true)

}

extension MovieViewModel {
    
    func fetchData() -> [DailyBoxOfficeList] {
        return self.dailyBoxOfficeData.value ?? []
    }
    
    func getDailyBoxOffice() -> Bool {
        let date = String.calculateDate()
        
        self.didChangeLoadingIndicator.value = true
        
        MainService.shared.getMovieList(date: date) { response in
            switch response {
            case .success(let data):
                guard let data = data as? GetMovieResponseModel else { return }
                self.dailyBoxOfficeData.value = data.boxOfficeResult.dailyBoxOfficeList
                
                self.didChangeLoadingIndicator.value = false
                self.didUpdateNetworkResult.value = true
                
            default:
                self.didUpdateNetworkResult.value = false
                return
            }
        }
        guard let networkResult = self.didUpdateNetworkResult.value else { return false }
        return networkResult
    }
}
