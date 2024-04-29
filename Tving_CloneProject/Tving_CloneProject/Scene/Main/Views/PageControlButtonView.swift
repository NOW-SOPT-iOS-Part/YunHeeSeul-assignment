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

class PageControlButtonView: UICollectionReusableView {
    
    // MARK: - UI Properties
    
    let buttonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // MARK: - UI Properties
        
    static let elementKinds: String = "PageControlButtonView"

    weak var delegate: PageControlButtonDelegate?

    static let identifier: String = "PageControlButtonView"
    
    private var prevIndex: Int = 0 {
        didSet {
            // 이전에 선택된 버튼을 찾기
            if let previousButton = buttonCollectionView.cellForItem(at: IndexPath(item: prevIndex, section: 0)) as? PagerButtonCell {
                previousButton.pagerButton.backgroundColor = UIColor(resource: .grey3)
                previousButton.pagerButton.isSelected = false
            }
        }
    }
    
    private var index: Int = 0 {
        didSet {
            prevIndex = oldValue
        }
    }
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedButtonStyle() {
        
    }
    
    @objc
    func didTapControlButton(_ sender: UIButton) {
        index = sender.tag
        self.delegate?.didTapControlButton(index: index)
        
        //이전과 같은 버튼을 탭하지 않는 경우
        if prevIndex != index {
            sender.isSelected = !sender.isSelected
        }
        sender.backgroundColor = !sender.isSelected ? UIColor(resource: .grey3) : UIColor(resource: .white)

    }
}


// MARK: - Private Methods

private extension PageControlButtonView {
    
    func setHierarchy() {
        
        self.addSubview(buttonCollectionView)
        
    }
    
    func setLayout() {
        
        buttonCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview()
        }
        
    }
    
    func setStyle() {
            
        buttonCollectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.isUserInteractionEnabled = true
            $0.register(PagerButtonCell.self, forCellWithReuseIdentifier: PagerButtonCell.identifier)
            $0.backgroundColor = UIColor(resource: .black)
        }
    }
    
}


// MARK: - Delegates

extension PageControlButtonView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ScreenUtils.getWidth(4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 6 , height: 6)
    }
}

extension PageControlButtonView: UICollectionViewDelegate {}

extension PageControlButtonView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Contents.mainPoster().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagerButtonCell.identifier, for: indexPath) as? PagerButtonCell
        else { return UICollectionViewCell() }
        
        cell.pagerButton.tag = indexPath.row
        cell.pagerButton.addTarget(self, action: #selector(didTapControlButton(_:)), for: .touchUpInside)
        if cell.pagerButton.tag == 0 {
            cell.pagerButton.isSelected = true
            cell.pagerButton.backgroundColor = UIColor(resource: .white)
            index = 0
        }
        
        return cell
    }
    
}
