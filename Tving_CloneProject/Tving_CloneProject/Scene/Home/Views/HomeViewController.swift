//
//  MainViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/22/24.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    // MARK: - UI Properties
            
    private let navigationBarView = NavigationBarView()
    
    private let headerCategoryView = HeaderCategoryView()
    
    private let stickyHeaderCategoryView = HeaderCategoryView()
    
    private let mainVC = MainViewController()
    
    private let liveView = LiveView()
    
    private let tvProgramView = TVProgramView()
    
    private let movieVC = MovieViewController()
    
    private let paramountView = ParamountView()
    
    private let dimmedView = UIView()
        
    
    // MARK: - Properties
    
    private var initializeCode: Bool = true
    
    private var selectedTabBarIndex: Int = 0
    
    private var shouldShowSticky: Bool = false
    
    private var tabBarHeight: CGFloat = 0 {
        didSet {
            mainVC.tabBarHeight = tabBarHeight
        }
    }
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        setDelegate()
        setSegmentDidChange()
    }
    
}


// MARK: - Private Methods

private extension HomeViewController {
    
    func setHierarchy() {
        
        self.view.addSubviews(mainVC.view,
                              navigationBarView,
                              dimmedView,
                              headerCategoryView,
                              liveView,
                              tvProgramView,
                              movieVC.view,
                              paramountView)
        dimmedView.addSubview(stickyHeaderCategoryView)
        self.view.bringSubviewToFront(dimmedView)
        self.view.bringSubviewToFront(navigationBarView)
        self.view.bringSubviewToFront(headerCategoryView)
    }
    
    func setLayout() {
        mainVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constant.Screen.topSafeAreaHeight)
            $0.width.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        headerCategoryView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        dimmedView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(Constant.Screen.topSafeAreaHeight + 40)
        }
        
        stickyHeaderCategoryView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        [liveView, tvProgramView, movieVC.view, paramountView].forEach {
            $0.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
    }
    
    func setStyle() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 40
        
        headerCategoryView.do {
            $0.segmentedControlView.addTarget(self, action: #selector(didChangeValue(sender: )), for: .valueChanged)
        }
        
        stickyHeaderCategoryView.do {
            $0.isHidden = true
            $0.segmentedControlView.addTarget(self, action: #selector(didChangeValue(sender: )), for: .valueChanged)
        }
        
        dimmedView.do {
            $0.isHidden = true
            $0.backgroundColor = UIColor(resource: .black)
        }

    }
    
    func setDelegate() {
        self.mainVC.mainView.mainCollectionView.delegate = self
    }
    
    func setSegmentDidChange() {
        self.didChangeValue(sender: self.headerCategoryView.segmentedControlView)
        self.didChangeValue(sender: self.stickyHeaderCategoryView.segmentedControlView)
        self.initializeCode = false
    }
    
    func setSegmentView(selectedIndex: Int) {
        let views = [mainVC.view, liveView, tvProgramView, movieVC.view, paramountView]
        
        for index in 0...4 {
            views[index]?.isHidden = index == selectedIndex ? false : true
        }
    }
    
    @objc
    func didChangeValue(sender: UISegmentedControl) {
        setSegmentView(selectedIndex: sender.selectedSegmentIndex)
        
        if stickyHeaderCategoryView.isHidden {
            headerCategoryView.segmentedControlView.moveUnderlineView(to: sender.selectedSegmentIndex)
            stickyHeaderCategoryView.segmentedControlView.moveUnderlineView(to: sender.selectedSegmentIndex)
            stickyHeaderCategoryView.segmentedControlView.selectedSegmentIndex = headerCategoryView.segmentedControlView.selectedSegmentIndex
        } else {
            stickyHeaderCategoryView.segmentedControlView.moveUnderlineView(to: sender.selectedSegmentIndex)
            headerCategoryView.segmentedControlView.moveUnderlineView(to: sender.selectedSegmentIndex)
            headerCategoryView.segmentedControlView.selectedSegmentIndex = stickyHeaderCategoryView.segmentedControlView.selectedSegmentIndex
        }
    }
    
}


// MARK: - Delegates

extension HomeViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // contentOffset.y: 손가락을 위로 올리면 + 값, 손가락을 아래로 내리면 - 값
        let topPadding = scrollView.safeAreaInsets.top
        
        shouldShowSticky = topPadding + scrollView.contentOffset.y > headerCategoryView.frame.minY
        
        dimmedView.isHidden = !shouldShowSticky
        navigationBarView.isHidden = shouldShowSticky
        headerCategoryView.isHidden = shouldShowSticky
        stickyHeaderCategoryView.isHidden = !shouldShowSticky
        
        if shouldShowSticky {
            for cell in mainVC.mainView.mainCollectionView.visibleCells {
                if let mainPosterCell = cell as? MainPosterCell {
                    dimmedView.alpha = scrollView.contentOffset.y / 100
                    mainPosterCell.alpha = 1 - scrollView.contentOffset.y / 500
                }
            }
        }
    }
}
