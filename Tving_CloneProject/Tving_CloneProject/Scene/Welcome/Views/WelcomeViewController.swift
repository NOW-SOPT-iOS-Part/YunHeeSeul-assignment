//
//  WelcomeViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/10/24.
//

import UIKit

import SnapKit
import Then

final class WelcomeViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let welcomeView = WelcomeView()
    
    
    // MARK: - Properties
        
    var userInfo: String? = ""
    
    private let welcomeViewModel = WelcomeViewModel()
    
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        bindUserInfo()
    }
    
}


// MARK: - Private Methods

private extension WelcomeViewController {
    
    func setStyle() {
        self.view.backgroundColor = UIColor(resource: .black)
        self.navigationController?.navigationBar.isHidden = true
        self.welcomeView.goToMainButton.addTarget(self, action: #selector(pushToMainVC), for: .touchUpInside)

    }
    
    func bindUserInfo() {
        if welcomeViewModel.checkNotEmptyNickname(nickname: self.userInfo) {
            self.welcomeView.welcomeLabel.text = "\(welcomeViewModel.fetchNickname())님\n반가워요!"
        }
    }
    
    @objc
    func pushToMainVC() {
        let tabBarVC = TabBarViewController()
        self.navigationController?.pushViewController(tabBarVC, animated: true)
    }
    
}
