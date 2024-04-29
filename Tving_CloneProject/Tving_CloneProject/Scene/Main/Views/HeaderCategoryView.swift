//
//  HeaderCategoryView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/26/24.
//

import UIKit

import SnapKit
import Then

class HeaderCategoryView: UIView {

    // MARK: - UI Property
    
    let segmentedControlView = UnderlineSegmentedControlView(items: ["홈", "실시간", "TV프로그램", "영화", "파라마운트+"])
    
    
    // MARK: - Life Cycle
    
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

private extension HeaderCategoryView {
    
    func setHierarchy() {
        
        self.addSubview(segmentedControlView)
        
    }
    
    func setLayout() {
        
        segmentedControlView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
    }
    
    func setStyle() {
        
        segmentedControlView.do {
            $0.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor(resource: .white),
                .font: UIFont.pretendard(.body2)], for: .normal)
            $0.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor(resource: .white),
                .font: UIFont.pretendard(.body2)], for: .selected)
            $0.apportionsSegmentWidthsByContent = true
            $0.selectedSegmentIndex = 0
            $0.backgroundColor = .clear
            $0.setWidth(Constant.Screen.width / (Constant.Screen.width / 45), forSegmentAt: 0)
            $0.setWidth(Constant.Screen.width / (Constant.Screen.width / 74), forSegmentAt: 1)
            $0.setWidth(Constant.Screen.width / (Constant.Screen.width / 108), forSegmentAt: 2)
            $0.setWidth(Constant.Screen.width / (Constant.Screen.width / 59), forSegmentAt: 3)
            $0.setWidth(Constant.Screen.width / (Constant.Screen.width / 112), forSegmentAt: 4)
        }

    }
    
    
}
