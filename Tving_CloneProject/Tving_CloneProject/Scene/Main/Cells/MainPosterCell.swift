//
//  MainPosterCell.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/22/24.
//

import UIKit

import SnapKit
import Then

final class MainPosterCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    private let buttonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // MARK: - Properties
    
    static let identifier: String = "MainPosterCell"
    
    lazy  var vcData: [UIViewController] = [] {
        didSet {
            setVCInPageVC()
        }
    }
    
    var imageData = Contents.mainPoster()
    
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
    
    func setPageVC(contents: Contents) {
        
        let vc = UIViewController()
        
        let imageView = UIImageView()
        imageView.image = contents.image
        
        vc.view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        vcData.append(vc)
            
    }
    
}


// MARK: - Private Methods

private extension MainPosterCell {
    
    func setHierarchy() {
        self.addSubviews(pageVC.view, buttonCollectionView)
    }
    
    func setLayout() {
        
        pageVC.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(ScreenUtils.getHeight(500))
        }
        
        buttonCollectionView.snp.makeConstraints {
            $0.top.equalTo(pageVC.view.snp.bottom).offset(22)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(ScreenUtils.getWidth(60))
            $0.height.equalTo(4)
        }
        
    }
    
    func setStyle() {
        
        buttonCollectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(PagerButtonCell.self, forCellWithReuseIdentifier: PagerButtonCell.identifier)
            $0.backgroundColor = UIColor(resource: .black)
        }
    }
    
    func setVCInPageVC() {
        if let firstVC = vcData.first {
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
}


// MARK: - Delegates

extension MainPosterCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ScreenUtils.getWidth(4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 4 , height: 4)
    }
}

extension MainPosterCell: UICollectionViewDelegate {}

extension MainPosterCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Contents.mainPoster().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagerButtonCell.identifier, for: indexPath) as? PagerButtonCell
        else { return UICollectionViewCell() }
        
        return cell
    }
    
}
