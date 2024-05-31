//
//  MainViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/23/24.
//

import UIKit

final class MainViewModel: NSObject {
    
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
    
    private var dailyBoxOfficeData: [DailyBoxOfficeList] = []
    
    let dataSource: [MainSection] = MainSection.dataSource
    
}

extension MainViewModel {
    
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
    
    func getDailyBoxOffice() {
        
        let date = calculateDate()
        
        self.isLoading = true
        
        MainService.shared.getMovieList(date: date) { response in
            switch response {
            case .success(let data):
                guard let data = data as? GetMovieResponseModel else { return }
                self.dailyBoxOfficeData = data.boxOfficeResult.dailyBoxOfficeList
                
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

extension MainViewModel: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.dataSource[section] {
        case .mainPoster:
            return 1
        case .recommendedContents:
            return recommendedData.count
        case .popularLiveChannel:
            return popularData.count
        case .paramounts:
            return paramountsData.count
        case .categories:
            return categoryData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.dataSource[indexPath.section] {
        case .mainPoster:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPosterCell.identifier, for: indexPath)
                    as? MainPosterCell else { return UICollectionViewCell() }
            cell.setPageVC(imageData: mainData)
            return cell
            
        case .recommendedContents, .paramounts:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageWithTitleCell.identifier, for: indexPath)
                    as? ImageWithTitleCell else { return UICollectionViewCell() }
            let data = dataSource[indexPath.section] == .recommendedContents
            ? recommendedData
            : paramountsData
            cell.setCell(contents: data[indexPath.row])
            return cell
            
        case .popularLiveChannel:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularLiveCell.identifier, for: indexPath)
                    as? PopularLiveCell else { return UICollectionViewCell() }
            cell.setCell(contents: popularData[indexPath.row])
            return cell
            
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageOnlyCell.identifier, for: indexPath)
                    as? ImageOnlyCell else { return UICollectionViewCell() }
            cell.setCell(contents: categoryData[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == BasicHeaderView.elementKinds {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BasicHeaderView.identifier, for: indexPath)
                    as? BasicHeaderView else { return UICollectionReusableView() }
            
            switch self.dataSource[indexPath.section] {
            case .mainPoster, .categories:
                return header
            case .recommendedContents:
                header.bindTitle(headerTitle: "티빙에서 꼭 봐야하는 콘텐츠")
            case .popularLiveChannel:
                header.bindTitle(headerTitle: "인기 LIVE 채널")
            case .paramounts:
                header.bindTitle(headerTitle: "1화 무료! 파라마운트+ 인기 시리즈")
            }
            return header
        } else if kind == PageControlButtonView.elementKinds {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PageControlButtonView.identifier, for: indexPath)
                    as? PageControlButtonView else { return UICollectionReusableView() }
            
            footer.buttonCount = mainData.count
            return footer
        } else {
            return UICollectionReusableView()
        }
        
    }
    
}

