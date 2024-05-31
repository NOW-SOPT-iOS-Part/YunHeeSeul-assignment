//
//  MovieViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/31/24.
//

import UIKit

final class MovieViewModel: NSObject {
    
    // MARK: - Properties
    
    private var dailyBoxOfficeData: [DailyBoxOfficeList] = []
    
    var didUpdateNetworkResult: ObservablePattern<Bool> = ObservablePattern(false)
    
    var didChangeLoadingIndicator: ObservablePattern<Bool> = ObservablePattern(true)

}

extension MovieViewModel {
    
    func getDailyBoxOffice() -> Bool {
        let date = String.calculateDate()
        
        self.didChangeLoadingIndicator.value = true
        
        MainService.shared.getMovieList(date: date) { response in
            switch response {
            case .success(let data):
                guard let data = data as? GetMovieResponseModel else { return }
                self.dailyBoxOfficeData = data.boxOfficeResult.dailyBoxOfficeList
                
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

extension MovieViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyBoxOfficeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCell.identifier, for: indexPath) as? DailyBoxOfficeCell else { return UICollectionViewCell() }
        cell.setCell(contents: dailyBoxOfficeData[indexPath.row])
        
        return cell
    }
    
}
