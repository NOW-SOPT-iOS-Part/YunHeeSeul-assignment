//
//  ParamountView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/7/24.
//

import UIKit

import SnapKit
import Then

final class ParamountView: UIView {

    // MARK: - UI Properties
    
    private let paramountView = UIView()
    
    
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

private extension ParamountView {
    
    func setHierarchy() {
        self.addSubview(paramountView)
    }
    
    func setLayout() {
        paramountView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setStyle() {
        paramountView.do {
            $0.isHidden = true
            $0.backgroundColor = UIColor(resource: .grey4)
        }
    }
    
}
