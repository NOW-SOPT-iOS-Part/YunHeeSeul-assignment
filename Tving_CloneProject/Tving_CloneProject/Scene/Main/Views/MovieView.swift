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
    
    private let movieView = UIView()
    
    
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

private extension MovieView {
    
    func setHierarchy() {
        self.addSubview(movieView)
    }
    
    func setLayout() {
        movieView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setStyle() {
        movieView.do {
            $0.isHidden = true
            $0.backgroundColor = UIColor(resource: .grey3)
        }
    }
    
}
