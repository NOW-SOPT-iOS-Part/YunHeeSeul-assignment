//
//  TabBarViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/29/24.
//

import UIKit

import Then

final class TabBarViewController: UITabBarController {
    
    // MARK: - UI Components
    
    let mainVC = HomeViewController()
    
    let toBeReleasedVC = ToBeReleasedViewController()
    
    let searchVC = SearchViewController()
    
    let historyVC = HistoryViewController()
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }
    
}


// MARK: - Private Methods

private extension TabBarViewController {
    
    func setStyle() {
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(resource: .black)
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
        self.selectedIndex = 0
        self.tabBar.tintColor = UIColor(resource: .white)
        self.viewControllers = [mainVC, toBeReleasedVC, searchVC, historyVC]
        
        mainVC.do {
            $0.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        }
        
        toBeReleasedVC.do {
            $0.tabBarItem = UITabBarItem(title: "공개예정", image: UIImage(systemName: "play.rectangle.on.rectangle"), selectedImage: UIImage(systemName: "play.rectangle.on.rectangle.fill"))
        }
        
        searchVC.do {
            $0.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        }
        
        historyVC.do {
            $0.tabBarItem = UITabBarItem(title: "기록", image: UIImage(systemName: "clock.arrow.circlepath"), selectedImage: UIImage(systemName: "clock.arrow.circlepath"))

        }
    }
    
}
