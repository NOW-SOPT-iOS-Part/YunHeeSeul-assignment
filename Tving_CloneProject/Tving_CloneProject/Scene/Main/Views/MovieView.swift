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
    
    private let dailyBoxOfficeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var loadingIndicator = UIActivityIndicatorView()
    
    
    // MARK: - Properties
    
    private var movieViewModel: MovieViewModel = MovieViewModel()
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
        setDelegate()
        registerCell()
        setViewModel()
        getDailyBoxOffice()
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
    
    func setViewModel() {
        movieViewModel.didUpdateNetworkResult.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.dailyBoxOfficeCollectionView.reloadData()
            }
        }
        
        movieViewModel.didChangeLoadingIndicator.bind { [weak self] isLoading in
            guard let isLoading else { return }
            if isLoading {
                self?.loadingIndicator.startAnimating()
            } else {
                self?.loadingIndicator.stopAnimating()
            }
        }

    }
    
    func getDailyBoxOffice() {
        if movieViewModel.getDailyBoxOffice() {
            self.dailyBoxOfficeCollectionView.reloadData()
        }
    }
    
    func registerCell() {
        dailyBoxOfficeCollectionView.register(DailyBoxOfficeCell.self, forCellWithReuseIdentifier: DailyBoxOfficeCell.identifier)
    }
    
    func setDelegate() {
        dailyBoxOfficeCollectionView.delegate = self
        dailyBoxOfficeCollectionView.dataSource = movieViewModel
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

