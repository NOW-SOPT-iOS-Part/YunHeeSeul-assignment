//
//  CompositionalLayout.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/6/24.
//

import UIKit

protocol CompositionalLayout {
    
    var itemSize: NSCollectionLayoutSize { get }
    
    var groupSize: NSCollectionLayoutSize { get }
        
    var itemContentInset: NSDirectionalEdgeInsets { get }
    
    var groupContentInset: NSDirectionalEdgeInsets { get }

    var sectionContentInset: NSDirectionalEdgeInsets { get }
    
    var supplemetaryItemSize: NSCollectionLayoutSize { get }

    var supplementaryAlignment: NSRectAlignment { get }
}

extension CompositionalLayout {
    
    var itemSize: NSCollectionLayoutSize {
        return NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    }
    
    var itemContentInset: NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
    }
    
    var groupContentInset: NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
    
    var sectionContentInset: NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
    
    var supplemetaryItemSize: NSCollectionLayoutSize {
        return NSCollectionLayoutSize(widthDimension: .fractionalWidth(0), heightDimension: .estimated(0))
    }
    
    var supplementaryAlignment: NSRectAlignment {
        return .top
    }

}


// MARK: - MainPosterLayout

struct MainPosterLayout: CompositionalLayout {

    var itemContentInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(550 / 812))

    var sectionContentInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 23, trailing: 0)
    
    var supplemetaryItemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(36))
    
    var supplementaryAlignment: NSRectAlignment = .bottom
}


// MARK: - ImageNTitleLayout

struct ImageNTitleLayout: CompositionalLayout {
    
    var groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(98 / 375), heightDimension: .fractionalHeight(170 / 812))
    
    var groupContentInset = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 0, trailing: 0)

    var sectionContentInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 40, trailing: 0)
    
    var supplemetaryItemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(25))
}


// MARK: - PopularLiveChannelLayout

struct PopularLiveChannelLayout: CompositionalLayout {
        
    var groupSize: NSCollectionLayoutSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(160 / 375), heightDimension: .fractionalHeight(140 / 812))
    
    var groupContentInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
    
    var sectionContentInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 40, trailing: 0)
    
    var supplemetaryItemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(25))
}


// MARK: - ImageOnlyLayout

struct ImageOnlyLayout: CompositionalLayout {
        
    var groupSize: NSCollectionLayoutSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(58 / 812))
        
    var sectionContentInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 100, trailing: 0)

}
