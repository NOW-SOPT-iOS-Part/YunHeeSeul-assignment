//
//  MainView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/3/24.
//

import UIKit

import SnapKit
import Then

final class MainView: UIView {
    
    // MARK: - UI Properties
    
    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeFlowLayout())
    
    
    // MARK: - Properties
    
    private var mainViewModel: MainViewModel = MainViewModel()
    
    private let mainPosterLayout: CompositionalLayout = MainPosterLayout()
    
    private let imageNTitleLayout: CompositionalLayout = ImageNTitleLayout()
    
    private let popularLiveChannelLayout: CompositionalLayout = PopularLiveChannelLayout()
    
    private let imageOnlyLayout: CompositionalLayout = ImageOnlyLayout()
    
    var tabBarHeight: CGFloat = 0 {
        didSet {
            mainCollectionView.reloadData()
        }
    }
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension MainView {
    
    func setHierarchy() {
        self.addSubview(mainCollectionView)
    }
    
    func setLayout() {
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setStyle() {
        mainCollectionView.do {
            $0.backgroundColor = UIColor(resource: .black)
            $0.showsVerticalScrollIndicator = false
            $0.contentInsetAdjustmentBehavior = .never
        }
    }
    
    func makeFlowLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, ev -> NSCollectionLayoutSection? in
            switch self.mainViewModel.dataSource[section] {
            case .mainPoster:
                return self.makeCompositionalLayout(layout: self.mainPosterLayout, type: PageControlButtonView.elementKinds)
            case .recommendedContents, .paramounts:
                return self.makeCompositionalLayout(layout: self.imageNTitleLayout, type: BasicHeaderView.elementKinds)
            case .popularLiveChannel:
                return self.makeCompositionalLayout(layout: self.popularLiveChannelLayout, type: BasicHeaderView.elementKinds)
            case .categories:
                return self.makeCompositionalLayout(layout: self.imageOnlyLayout, type: nil)
            }
        }
    }
    
    func makeCompositionalLayout(layout: CompositionalLayout, type: String?) -> NSCollectionLayoutSection{
        let itemSize = layout.itemSize
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = layout.itemContentInset
        
        
        let groupSize = layout.groupSize
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = layout.groupContentInset
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = layout.sectionContentInset
        
        guard let type else { return section }
        let supplemetaryItem = makeSupplementaryLayout(layout: layout, type: type)
        section.boundarySupplementaryItems = [supplemetaryItem]
        
        return section
    }
    
    func makeSupplementaryLayout(layout: CompositionalLayout , type: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        let supplemetaryItemSize = layout.supplemetaryItemSize
        let supplemetaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplemetaryItemSize,
                                                                           elementKind: type,
                                                                           alignment: layout.supplementaryAlignment)
        return supplemetaryItem
    }
    
}
