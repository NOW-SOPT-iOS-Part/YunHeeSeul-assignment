//
//  LoadingView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/7/24.
//

import UIKit

import SnapKit
import Then

class LoadingView: UIActivityIndicatorView {

    // MARK: - UI Properties
    
    private let liveView = UIView()
    
    
    // MARK: - Properties
    
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

private extension LoadingView {
    
    func setHierarchy() {
        self.addSubview(liveView)
    }
    
    func setLayout() {
        liveView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setStyle() {
        loadingIndicator.do {
            $0.style = .large
            $0.center = view.center
            $0.frame = view.bounds
            $0.backgroundColor = UIColor(resource: .black)
            $0.color = UIColor(resource: .white)
            $0.layer.zPosition = 1
        }
    }
    
}
