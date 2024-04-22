//
//  MainViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/22/24.
//

import UIKit

import SnapKit
import Then


enum MainSection {
    case mainPoster([Contents])
    case recommendedContents([Contents])
//    case paramounts([Contents])
//    case romance([Contents])
//    case comedy([Contents])
}

class MainViewController: UIViewController {
    
    // MARK: - UI Properties
        
    private lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeFlowLayout())
    
    private let navigationBarView = NavigationBarView()
    
    
    // MARK: - Properties
    
    private let dataSource: [MainSection] = [
        MainSection.mainPoster(Contents.mainPoster()),
        MainSection.recommendedContents(Contents.recommended()),
//        MainSection.paramounts(Contents.paramounts()),
//        MainSection.romance(Contents.romance()),
//        MainSection.comedy(Contents.comedy())
    ]
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setLayout()
        setStyle()
    }


}


// MARK: - Private Methods

private extension MainViewController {

    func setHierarchy() {
        
        self.view.addSubviews(mainCollectionView)
        mainCollectionView.addSubviews(navigationBarView)
        
    }
    
    func setLayout() {
        
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(55)
            $0.width.equalToSuperview()
            $0.height.equalTo(ScreenUtils.getHeight(30))
        }

    }
    
    func setStyle() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        mainCollectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .black
            $0.contentInsetAdjustmentBehavior = .never
            $0.register(BasicCell.self, forCellWithReuseIdentifier: BasicCell.identifier)
            $0.register(MainPosterCell.self, forCellWithReuseIdentifier:MainPosterCell.identifier)
            $0.register(BasicHeaderView.self,
                        forSupplementaryViewOfKind: BasicHeaderView.elementKinds,
                        withReuseIdentifier: BasicHeaderView.identifier)

        }
    }
    
    func makeFlowLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, ev -> NSCollectionLayoutSection? in
            
            switch self.dataSource[section] {
            case .mainPoster:
                return self.makeMainPosterLayout()
            case .recommendedContents:
                return self.makeRecommendationLayout()
//            case .paramounts:
//                return self.makeParamountsLayout()
//            case .romance:
//                return self.makeRomanceLayout()
//            case .comedy:
//                return self.makeComedyLayout()
            }
            
        }
    }
    
    func makeMainPosterLayout() -> NSCollectionLayoutSection {
        // item
       let itemSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1),
           heightDimension: .fractionalHeight(1))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       
       // group
       let groupSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1),
           heightDimension: .fractionalHeight(550 / 812))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       
       // section
       let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, 
                                                        leading: 0,
                                                        bottom: 23,
                                                        trailing: 0)
       
       return section
    }
    
    func makeRecommendationLayout() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, 
                                                     leading: 0,
                                                     bottom: 0,
                                                     trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(98 / 375),
            heightDimension: .absolute(168))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 14, 
                                                      leading: 0,
                                                      bottom: 0, 
                                                      trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, 
                                                        leading: 15,
                                                        bottom: 0,
                                                        trailing: 0)
        
        let header = makeHeaderView()
        section.boundarySupplementaryItems = [header]
       
        return section
    }
//    
//    func makeParamountsLayout() -> NSCollectionLayoutSection {
//        
//    }
//    
//    func makeRomanceLayout() -> NSCollectionLayoutSection {
//        
//    }
//    
//    func makeComedyLayout() -> NSCollectionLayoutSection {
//        
//    }
    
    func makeHeaderView() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(25))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: BasicHeaderView.identifier,
            alignment: .top)
        
        return header
        
    }
    
}

extension MainViewController: UICollectionViewDelegate {}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch dataSource[section] {
        case .mainPoster(let data):
            return data.count
        case .recommendedContents(let data):
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch dataSource[indexPath.section] {
        case .mainPoster(let data):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPosterCell.identifier, for: indexPath)
                    as? MainPosterCell else { return UICollectionViewCell() }
            cell.setPageVC(contents: data[indexPath.row])
            return cell
        case .recommendedContents(let data):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCell.identifier, for: indexPath)
                    as? BasicCell else { return UICollectionViewCell() }
            cell.setData(data: data[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == BasicHeaderView.elementKinds {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, 
                                                                               withReuseIdentifier: BasicHeaderView.identifier,
                                                                               for: indexPath)
                    as? BasicHeaderView else { return UICollectionReusableView()}
            
            switch dataSource[indexPath.section] {
            case .mainPoster:
                return header
            case .recommendedContents:
                header.bindTitle(headerTitle: "티빙에서 꼭 봐야하는 콘텐츠")
                return header
            }
        } else {
            return UICollectionReusableView()
        }
        
    }
    
    
}
