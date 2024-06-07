//
//  MovieViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/3/24.
//

import UIKit

import SnapKit
import Then

final class MovieViewController: UIViewController {

    // MARK: - UI Properties

    private let movieView = MovieView()
    
    private let loadingIndicator = UIActivityIndicatorView()

    
    // MARK: - Properties

    private var movieViewModel: MovieViewModel = MovieViewModel()
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setLayout()
        setStyle()
        setDelegate()
        registerCell()
        setViewModel()
        getDailyBoxOffice()
    }

}


private extension MovieViewController {
    
    func setHierarchy() {
        self.view.addSubviews(movieView, loadingIndicator)
    }
    
    func setLayout() {
        movieView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setStyle() {
        loadingIndicator.do {
            $0.frame = view.bounds
            $0.color = UIColor(resource: .white)
            $0.backgroundColor = UIColor(resource: .black)
        }
    }
    
    func setViewModel() {
        movieViewModel.didUpdateNetworkResult.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.movieView.dailyBoxOfficeCollectionView.reloadData()
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
            self.movieView.dailyBoxOfficeCollectionView.reloadData()
        }
    }
    
    func registerCell() {
        self.movieView.dailyBoxOfficeCollectionView.register(DailyBoxOfficeCell.self, forCellWithReuseIdentifier: DailyBoxOfficeCell.identifier)
    }
    
    func setDelegate() {
        movieView.dailyBoxOfficeCollectionView.delegate = self
        movieView.dailyBoxOfficeCollectionView.dataSource = self
    }
    
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    
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

extension MovieViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieViewModel.fetchData().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCell.identifier, for: indexPath) as? DailyBoxOfficeCell else { return UICollectionViewCell() }
        cell.setCell(contents: movieViewModel.fetchData()[indexPath.row])
        
        return cell
    }
    
}
