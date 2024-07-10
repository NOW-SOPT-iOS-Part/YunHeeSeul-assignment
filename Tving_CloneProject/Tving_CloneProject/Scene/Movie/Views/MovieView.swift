//
//  MovieView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/7/24.
//

import UIKit

import SnapKit
import Then

final class MovieView: UIView {
    
    // MARK: - UI Properties
    
    let dailyBoxOfficeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let loadingIndicator = UIActivityIndicatorView()

    
    // MARK: - Life Cycles
    
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

private extension MovieView {
    
    func setHierarchy() {
        self.addSubviews(dailyBoxOfficeCollectionView, loadingIndicator)
    }
    
    func setLayout() {
        dailyBoxOfficeCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constant.Screen.topSafeAreaHeight + 80)
            $0.horizontalEdges.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setStyle() {
        dailyBoxOfficeCollectionView.do {
            $0.backgroundColor = UIColor(resource: .black)
            $0.showsVerticalScrollIndicator = false
        }
        
        loadingIndicator.do {
            $0.frame = self.bounds
            $0.color = UIColor(resource: .white)
            $0.backgroundColor = UIColor(resource: .black)
        }
    }

}
