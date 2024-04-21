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
//    case recommendedContents([Contents])
//    case paramounts([Contents])
//    case romance([Contents])
//    case comedy([Contents])
}

class MainViewController: UIViewController {
    
    // MARK: - UI Properties
        
    private lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeFlowLayout())
    
    
    // MARK: - Properties
    
    private let dataSource: [MainSection] = [
        MainSection.mainPoster(Contents.mainPoster()),
//        MainSection.recommendedContents(Contents.recommended()),
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
    }
    
    func setLayout() {
        
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }
    
    func setStyle() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        mainCollectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(MainPosterCell.self, forCellWithReuseIdentifier: MainPosterCell.identifier)
            $0.contentInsetAdjustmentBehavior = .never
            $0.backgroundColor = .black
        }
    }
    
    func makeFlowLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, ev -> NSCollectionLayoutSection? in
            
            switch self.dataSource[section] {
            case .mainPoster:
                return self.makeMainPosterLayout()
//            case .recommendedContents:
//                return self.makeRecommendationLayout()
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
           heightDimension: .absolute(550))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       
       // group
       let groupSize = NSCollectionLayoutSize(
           widthDimension: .fractionalWidth(1),
           heightDimension: .fractionalHeight(1))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       
       // section
       let section = NSCollectionLayoutSection(group: group)
       section.orthogonalScrollingBehavior = .continuous // 수평 스크롤
       section.contentInsets = NSDirectionalEdgeInsets(
           top: 0,
           leading: 0,
           bottom: 0,
           trailing: 0)
       
       
       return section
    }
    
//    func makeRecommendationLayout() -> NSCollectionLayoutSection {
//        
//    }
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
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch dataSource[indexPath.section] {
        case .mainPoster(let data):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPosterCell.identifier, for: indexPath) as? MainPosterCell
            else { return UICollectionViewCell() }
            cell.setPageVC(contents: data[indexPath.row])
            return cell
        }
    }
    
    
}
