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
    
    let selectedButton: SelectedButtonStatus = SelectedPageControlButton()
    
    let notSelectedButton: SelectedButtonStatus = NotSelectedPageControlButton()
    
    
    // MARK: - UI Properties
    
    private var initialCode: Bool = true
        
    static let elementKinds: String = "footer"

    weak var delegate: PageControlButtonDelegate?

    static let identifier: String = "PageControlButtonView"
        
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
        buttonCollectionView.dataSource = self
    }
    
    func setButtonStyle(isSelected: Bool, button: UIButton) {
        if isSelected {
            button.setSelectedButtonStatus(buttonStatus: selectedButton)
        } else {
            button.setSelectedButtonStatus(buttonStatus: notSelectedButton)
        }
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
extension PageControlButtonView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagerButtonCell.identifier, for: indexPath) as? PagerButtonCell
        else { return UICollectionViewCell() }
        
        cell.pagerButton.tag = indexPath.row

        return cell
    }
    
}
