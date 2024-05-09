//
//  MovieView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/7/24.
//

import UIKit

import SnapKit
import Then

class MovieView: UIView {
    
    // MARK: - UI Properties
    
    private let dailyBoxOfficeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var loadingIndicator = UIActivityIndicatorView()
    
    
    // MARK: - Properties
    
    private var dailyBoxOfficeData: [DailyBoxOfficeList] = []
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        getDailyBoxOffice()
        setHierarchy()
        setLayout()
        setStyle()
        setDelegate()
        registerCell()
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
        }
        
        loadingIndicator.do {
            $0.frame = self.bounds
            $0.color = UIColor(resource: .white)
            $0.backgroundColor = UIColor(resource: .black)
        }
    }
    
    func registerCell() {
        
        dailyBoxOfficeCollectionView.register(DailyBoxOfficeCell.self, forCellWithReuseIdentifier: DailyBoxOfficeCell.identifier)
    }
    
    func setDelegate() {
        
        dailyBoxOfficeCollectionView.delegate = self
        dailyBoxOfficeCollectionView.dataSource = self
    }
    
        }
    }
    
}

extension MovieView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constant.Screen.width / 2 - 20, height: Constant.Screen.height / 3.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension MovieView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dailyBoxOfficeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCell.identifier, for: indexPath) as? DailyBoxOfficeCell else { return UICollectionViewCell() }
        cell.setCell(contents: dailyBoxOfficeData[indexPath.row])
        
        return cell
    }
    
    
    
    
}
