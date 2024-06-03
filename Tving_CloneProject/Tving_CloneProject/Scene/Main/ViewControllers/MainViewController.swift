//
//  MainViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/22/24.
//

import UIKit

import SnapKit
import Then

final class MainViewController: UIViewController {
    
    // MARK: - UI Properties
        
    private lazy var mainView = MainView(tabBarHeight: self.tabBarController?.tabBar.frame.height ?? 40.0)
    
    private let navigationBarView = NavigationBarView()
    
    private let headerCategoryView = HeaderCategoryView()
    
    private let stickyHeaderCategoryView = HeaderCategoryView()
    
    private let liveView = LiveView()
    
    private let tvProgramView = TVProgramView()
    
    private let movieView = MovieView()
    
    private let paramountView = ParamountView()
    
    private let dimmedView = UIView()
    
    private var loadingIndicator = UIActivityIndicatorView()
    
    
    // MARK: - Properties
    
    private var mainViewModel: MainViewModel = MainViewModel()
    
    private var prevValue: Int = 0
    
    private var newValue: Int = 0
    
    private var currentPage: Int = 0 {
        didSet {
            prevValue = oldValue
            newValue = currentPage
        }
    }
    
    private var initializeCode: Bool = true
    
    private var selectedTabBarIndex: Int = 0
    
    private var shouldShowSticky: Bool = false
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        setDelegate()
        registerCell()
        setViewModel()
        getMovieInfo()
        setSegmentDidChange()
    }
    
}


// MARK: - Private Methods

private extension MainViewController {
    
    func setHierarchy() {
        
        self.view.addSubviews(mainView,
                              navigationBarView,
                              dimmedView,
                              headerCategoryView,
                              liveView,
                              tvProgramView,
                              movieView,
                              paramountView,
                              loadingIndicator)
        dimmedView.addSubview(stickyHeaderCategoryView)
        self.view.bringSubviewToFront(dimmedView)
        self.view.bringSubviewToFront(navigationBarView)
        self.view.bringSubviewToFront(headerCategoryView)
    }
    
    func setLayout() {
        
        mainView.snp.makeConstraints {
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
        
        [liveView, tvProgramView, movieView, paramountView].forEach {
            $0.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
    }
    
    func setStyle() {
        
        self.navigationController?.navigationBar.isHidden = true
        
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
        
        loadingIndicator.do {
            $0.frame = view.bounds
            $0.color = UIColor(resource: .white)
            $0.backgroundColor = UIColor(resource: .black)
        }
    }
    
    func setViewModel() {
        mainViewModel.didUpdateNetworkResult.bind { [weak self] isSuccess in
            guard let isSuccess else { return }
            if isSuccess {
                self?.mainView.mainCollectionView.reloadData()
            }
        }
        
        mainViewModel.didChangeLoadingIndicator.bind { [weak self] isLoading in
            guard let isLoading else { return }
            if isLoading {
                self?.loadingIndicator.startAnimating()
            } else {
                self?.loadingIndicator.stopAnimating()
            }
        }
    }
    
    func getMovieInfo() {
        if mainViewModel.getMovieInfo() {
            self.mainView.mainCollectionView.reloadData()
        }
    }
    
    func setDelegate() {
        mainView.mainCollectionView.delegate = self
        mainView.mainCollectionView.dataSource = self
    }
    
    func registerCell() {
        mainView.mainCollectionView.do {
            $0.register(ImageOnlyCell.self, forCellWithReuseIdentifier: ImageOnlyCell.identifier)
            $0.register(MainPosterCell.self, forCellWithReuseIdentifier:MainPosterCell.identifier)
            $0.register(PopularLiveCell.self, forCellWithReuseIdentifier: PopularLiveCell.identifier)
            $0.register(ImageWithTitleCell.self, forCellWithReuseIdentifier: ImageWithTitleCell.identifier)
            $0.register(BasicHeaderView.self,
                        forSupplementaryViewOfKind: BasicHeaderView.elementKinds,
                        withReuseIdentifier: BasicHeaderView.identifier)
            $0.register(PageControlButtonView.self,
                        forSupplementaryViewOfKind: PageControlButtonView.elementKinds,
                        withReuseIdentifier: PageControlButtonView.identifier)
        }
    }
    
    func setSegmentDidChange() {
        self.didChangeValue(sender: self.headerCategoryView.segmentedControlView)
        self.didChangeValue(sender: self.stickyHeaderCategoryView.segmentedControlView)
        self.initializeCode = false
    }
    
    func setSegmentView(selectedIndex: Int) {
        let views = [mainView, liveView, tvProgramView, movieView, paramountView]
        
        for index in 0...4 {
            views[index].isHidden = index == selectedIndex ? false : true
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

extension MainViewController: PageControlButtonDelegate {
    
    func didTapControlButton(index: Int) {
        currentPage = index
        
        let direction: UIPageViewController.NavigationDirection = prevValue < newValue ? .forward : .reverse
        for cell in mainView.mainCollectionView.visibleCells {
            if let mainPosterCell = cell as? MainPosterCell {
                mainPosterCell.pageVC.setViewControllers([mainPosterCell.vcData[currentPage]],
                                                         direction: direction,
                                                         animated: true,
                                                         completion: nil)
            }
        }
    }
    
}

extension MainViewController: MainPosterDelegate {
    
    func didSwipePoster(index: Int, vc: UIPageViewController, vcData: [UIViewController]) {
        currentPage = index
        
        if let pageControlButtonView = mainView.mainCollectionView.supplementaryView(forElementKind: PageControlButtonView.elementKinds, at: IndexPath(item: 0, section: 0))
            as? PageControlButtonView { pageControlButtonView.index = currentPage }
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // contentOffset.y: 손가락을 위로 올리면 + 값, 손가락을 아래로 내리면 - 값
        let topPadding = scrollView.safeAreaInsets.top
        
        shouldShowSticky = topPadding + scrollView.contentOffset.y > headerCategoryView.frame.minY
        
        dimmedView.isHidden = !shouldShowSticky
        navigationBarView.isHidden = shouldShowSticky
        headerCategoryView.isHidden = shouldShowSticky
        stickyHeaderCategoryView.isHidden = !shouldShowSticky
        
        if shouldShowSticky {
            for cell in mainView.mainCollectionView.visibleCells {
                if let mainPosterCell = cell as? MainPosterCell {
                    dimmedView.alpha = scrollView.contentOffset.y / 100
                    mainPosterCell.alpha = 1 - scrollView.contentOffset.y / 500
                }
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mainViewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch mainViewModel.dataSource[section] {
        case .mainPoster:
            return 1
        case .recommendedContents:
            return mainViewModel.fetchData(type: .recommendedContents).count
        case .popularLiveChannel:
            return mainViewModel.fetchData(type: .popularLiveChannel).count
        case .paramounts:
            return mainViewModel.fetchData(type: .paramounts).count
        case .categories:
            return mainViewModel.fetchData(type: .categories).count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch mainViewModel.dataSource[indexPath.section] {
        case .mainPoster:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPosterCell.identifier, for: indexPath)
                    as? MainPosterCell else { return UICollectionViewCell() }
            cell.setPageVC(imageData: mainViewModel.fetchData(type: .mainPoster))
            cell.delegate = self
            return cell
            
        case .recommendedContents, .paramounts:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageWithTitleCell.identifier, for: indexPath)
                    as? ImageWithTitleCell else { return UICollectionViewCell() }
            let data = mainViewModel.dataSource[indexPath.section] == .recommendedContents
            ? mainViewModel.fetchData(type: .recommendedContents)
            : mainViewModel.fetchData(type: .paramounts)
            cell.setCell(contents: data[indexPath.row])
            return cell
            
        case .popularLiveChannel:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularLiveCell.identifier, for: indexPath)
                    as? PopularLiveCell else { return UICollectionViewCell() }
            cell.setCell(contents: mainViewModel.fetchData(type: .popularLiveChannel)[indexPath.row])
            return cell
            
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageOnlyCell.identifier, for: indexPath)
                    as? ImageOnlyCell else { return UICollectionViewCell() }
            cell.setCell(contents: mainViewModel.fetchData(type: .categories)[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == BasicHeaderView.elementKinds {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BasicHeaderView.identifier, for: indexPath)
                    as? BasicHeaderView else { return UICollectionReusableView() }
            
            switch mainViewModel.dataSource[indexPath.section] {
            case .mainPoster, .categories:
                return header
            case .recommendedContents:
                header.bindTitle(headerTitle: "티빙에서 꼭 봐야하는 콘텐츠")
            case .popularLiveChannel:
                header.bindTitle(headerTitle: "인기 LIVE 채널")
            case .paramounts:
                header.bindTitle(headerTitle: "1화 무료! 파라마운트+ 인기 시리즈")
            }
            return header
        } else if kind == PageControlButtonView.elementKinds {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PageControlButtonView.identifier, for: indexPath)
                    as? PageControlButtonView else { return UICollectionReusableView() }
            
            footer.buttonCount = mainViewModel.fetchData(type: .mainPoster).count
            footer.delegate = self
            return footer
        } else {
            return UICollectionReusableView()
        }
        
    }
    
}

