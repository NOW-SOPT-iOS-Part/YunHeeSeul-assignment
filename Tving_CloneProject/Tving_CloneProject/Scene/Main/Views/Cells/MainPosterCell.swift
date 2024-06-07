//
//  MainPosterCell.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/22/24.
//

import UIKit

import SnapKit
import Then

protocol MainPosterDelegate: AnyObject {
    func didSwipePoster(index: Int, vc: UIPageViewController, vcData: [UIViewController])
}

final class MainPosterCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    
    // MARK: - Properties
        
    var vcData: [UIViewController] = []

    weak var delegate: MainPosterDelegate?
    
    static let identifier: String = "MainPosterCell"
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPageVC(imageData: [Contents]) {
        imageData.forEach {
            let vc = UIViewController()
            
            let imageView = UIImageView()
            imageView.image = $0.image
            
            vc.view.addSubview(imageView)
            imageView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            vcData += [vc]
        }
        setVCInPageVC()
    }
}


// MARK: - Private Methods

private extension MainPosterCell {
    
    func setHierarchy() {
        self.addSubview(pageVC.view)
    }
    
    func setLayout() {
        pageVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func setVCInPageVC() {
        if let firstVC = vcData.first {
            pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func setDelegate() {
        pageVC.delegate = self
        pageVC.dataSource = self
    }
    
}

extension MainPosterCell: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = vcData.firstIndex(of: currentVC) else { return }
        
        self.delegate?.didSwipePoster(index: currentIndex, vc: pageViewController, vcData: vcData)
        
    }
    
}

extension MainPosterCell: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = vcData.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        
        return vcData[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = vcData.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = index + 1
        if nextIndex == vcData.count {
            return nil
        }
        
        return vcData[nextIndex]
    }
}
