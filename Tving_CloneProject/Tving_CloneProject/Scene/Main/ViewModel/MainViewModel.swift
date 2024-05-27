//
//  MainViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/23/24.
//

import UIKit

final class MainViewModel {
    
    // MARK: - Properties
    
    private var isSuccess: Bool = false {
        didSet {
            self.didUpdateNetworkResult?(isSuccess)
        }
    }
    
    private var isLoading: Bool = true {
        didSet {
            self.didChangeLoadingIndicator?(isLoading)
        }
    }
    
    var didUpdateNetworkResult: ((Bool) -> Void)?
    
    var didChangeLoadingIndicator: ((Bool) -> Void)?
    
    private var mainData: [Contents] = []
    
    private var recommendedData: [Contents] = []

    private var popularData: [Contents] = []

    private var paramountsData: [Contents] = []

    private var categoryData: [Contents] = []
    
    let dataSource: [MainSection] = MainSection.dataSource
    
}

extension MainViewModel {
    
    func fetchMainData() -> [Contents] {
        return self.mainData
    }
    
    func fetchRecommendedData() -> [Contents] {
        return self.recommendedData
    }
    
    func fetchParamountsData() -> [Contents] {
        return self.paramountsData
    }
    
    func fetchCategoryData() -> [Contents] {
        return self.categoryData
    }
    
    func fetchPopularData() -> [Contents] {
        return self.popularData
    }
    
    func getMovieInfo() {
        let currentDate = calculateDate()
        
        self.isLoading = true
        
        MainService.shared.getMovieList(date: currentDate) { response in
            switch response {
            case .success(let data):
                guard let data = data as? GetMovieResponseModel else { return }
                var count = 0
                for i in data.boxOfficeResult.dailyBoxOfficeList {
                    self.mainData.append(Contents(image: Contents.posterImages[count]))
                    self.recommendedData.append(Contents(image: Contents.posterImages[count], title: i.movieNm))
                    self.paramountsData.append(Contents(image: Contents.posterImages[count], title: i.movieNm))
                    self.categoryData.append(Contents(image: Contents.categoryImages[count]))
                    self.popularData.append(Contents(image: Contents.posterImages[count],
                                                     title: i.movieNm,
                                                     ranking: "\(count + 1)",
                                                     channelName: "tvn",
                                                     rating: i.salesShare))
                    count+=1
                }
                self.isLoading = false
                self.isSuccess = true
                
            default:
                return
            }
        }
    }
    
    func calculateDate() -> String {

        let today = Date()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = -1

        if let oneDayAgo = calendar.date(byAdding: dateComponents, to: today) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            
            let oneDayAgoString = dateFormatter.string(from: oneDayAgo)
            return oneDayAgoString
        } else {
            return ""
        }
    }
}
