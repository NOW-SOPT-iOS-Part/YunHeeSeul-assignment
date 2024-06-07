//
//  MainViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/23/24.
//

import Foundation

final class MainViewModel {
    
    // MARK: - Properties
    
    var didUpdateNetworkResult: ObservablePattern<Bool> = ObservablePattern(false)
    
    var didChangeLoadingIndicator: ObservablePattern<Bool> = ObservablePattern(true)
    
    private var mainData: ObservablePattern<[Contents]> = ObservablePattern.init([])
    
    private var recommendedData: ObservablePattern<[Contents]> = ObservablePattern.init([])
    
    private var popularData: ObservablePattern<[Contents]> = ObservablePattern.init([])
    
    private var paramountsData: ObservablePattern<[Contents]> = ObservablePattern.init([])
    
    private var categoryData: ObservablePattern<[Contents]> = ObservablePattern.init([])
    
    let dataSource: [MainSection] = MainSection.dataSource
    
}

extension MainViewModel {
    
    func fetchData(type: MainSection) -> [Contents] {
        switch type {
        case .mainPoster:
            return self.mainData.value ?? []
        case .recommendedContents:
            return self.recommendedData.value ?? []
        case .popularLiveChannel:
            return self.popularData.value ?? []
        case .paramounts:
            return self.paramountsData.value ?? []
        case .categories:
            return self.categoryData.value ?? []
        }
    }
    
    func getMovieInfo() -> Bool {
        let currentDate = String.calculateDate()
        
        self.didChangeLoadingIndicator.value = true
        
        MainService.shared.getMovieList(date: currentDate) { response in
            switch response {
            case .success(let data):
                guard let data = data as? GetMovieResponseModel else { return }
                var count = 0
                for i in data.boxOfficeResult.dailyBoxOfficeList {
                    self.mainData.value?.append(Contents(image: Contents.posterImages[count]))
                    self.recommendedData.value?.append(Contents(image: Contents.posterImages[count], title: i.movieNm))
                    self.paramountsData.value?.append(Contents(image: Contents.posterImages[count], title: i.movieNm))
                    self.categoryData.value?.append(Contents(image: Contents.categoryImages[count]))
                    self.popularData.value?.append(Contents(image: Contents.posterImages[count],
                                                     title: i.movieNm,
                                                     ranking: "\(count + 1)",
                                                     channelName: "tvn",
                                                     rating: i.salesShare))
                    count+=1
                }
                self.didChangeLoadingIndicator.value = false
                self.didUpdateNetworkResult.value = true
                
            default:
                self.didUpdateNetworkResult.value = false
                return
            }
        }
        guard let networkResult = self.didUpdateNetworkResult.value else { return false}
        return networkResult
    }
    
}
