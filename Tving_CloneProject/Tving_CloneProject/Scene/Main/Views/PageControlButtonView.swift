//
//  PageControlButtonView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/29/24.
//

import UIKit

protocol PageControlButtonDelegate: AnyObject {
    func didTapControlButton(index: Int)
}

final class PageControlButtonView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    let buttonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // MARK: - UI Properties
    
    private var initialCode: Bool = true
        
    static let elementKinds: String = "footer"

    weak var delegate: PageControlButtonDelegate?

    static let identifier: String = "PageControlButtonView"
    
    private let pageControlButtonViewModel: PageControlButtonViewModel = PageControlButtonViewModel()
    
    private var prevIndex: Int = 0 {
        didSet {
            // 이전에 선택된 버튼을 찾기
            if let previousButton = buttonCollectionView.cellForItem(at: IndexPath(item: prevIndex, section: 0)) as? PagerButtonCell {
                if prevIndex != index {
                    setButtonStyle(isSelected: false, button: previousButton.pagerButton)
                }
            }
        }
    }
    
    var index: Int = 0 {
        didSet {
            // 현재 선택된 버튼을 찾기
            if let presentButton = buttonCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? PagerButtonCell {
                setButtonStyle(isSelected: true, button: presentButton.pagerButton)
            }
            prevIndex = oldValue
        }
    }
    
    var buttonCount: Int = 0 {
        didSet {
            pageControlButtonViewModel.buttonCount.value = buttonCount
            buttonCollectionView.reloadData()
        }
    }
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func didTapControlButton(_ sender: UIButton) {
        index = sender.tag
        self.delegate?.didTapControlButton(index: index)
    }
}


// MARK: - Private Methods

private extension PageControlButtonView {
    
    func setHierarchy() {
        self.addSubview(buttonCollectionView)
    }
    
    func setLayout() {
        buttonCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setStyle() {
        buttonCollectionView.do {
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = UIColor(resource: .black)
            $0.register(PagerButtonCell.self, forCellWithReuseIdentifier: PagerButtonCell.identifier)
        }
    }
    
    func setDelegate() {
        buttonCollectionView.delegate = self
        buttonCollectionView.dataSource = pageControlButtonViewModel
    }
    
    func setButtonStyle(isSelected: Bool, button: UIButton) {
        button.isSelected = isSelected ? true : false
        button.backgroundColor = isSelected ? UIColor(resource: .white) : UIColor(resource: .grey3)
    }
    
}


// MARK: - Delegates

extension PageControlButtonView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 6 , height: 6)
    }
}

extension PageControlButtonView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let pageButtonCell = cell as? PagerButtonCell {
            pageButtonCell.pagerButton.addTarget(self, action: #selector(didTapControlButton(_:)), for: .touchUpInside)
            
            if indexPath.row == index {
                setButtonStyle(isSelected: true, button: pageButtonCell.pagerButton)
            } else {
                setButtonStyle(isSelected: false, button: pageButtonCell.pagerButton)
            }
        }
    }
}
