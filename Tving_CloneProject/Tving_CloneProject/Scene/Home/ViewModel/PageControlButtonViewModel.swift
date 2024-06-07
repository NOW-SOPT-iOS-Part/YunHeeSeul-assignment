//
//  PageControlButtonViewModel.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/31/24.
//

import UIKit

final class PageControlButtonViewModel: NSObject {
    var buttonCount: ObservablePattern<Int> = ObservablePattern.init(0)
}

extension PageControlButtonViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = buttonCount.value else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagerButtonCell.identifier, for: indexPath) as? PagerButtonCell
        else { return UICollectionViewCell() }
        
        cell.pagerButton.tag = indexPath.row

        return cell
    }
    
}
