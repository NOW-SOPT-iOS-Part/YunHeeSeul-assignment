//
//  ImageOnlyCell.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/24/24.
//

import UIKit

class ImageOnlyCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    let posterImageView: UIImageView = UIImageView()
    
    
    // MARK: - Properties
    
    static let identifier: String = "ImageOnlyCell"
        
    
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
    
    func setCell(contents: Contents) {
        posterImageView.image = contents.image
    }
    
}

// MARK: - Private Methods

private extension ImageOnlyCell {
    
    func setHierarchy() {
        self.addSubview(posterImageView)
    }
    
    func setLayout() {
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setStyle() {
        posterImageView.do {
            $0.backgroundColor = UIColor(resource: .grey4)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 3
        }
    }
    
}
