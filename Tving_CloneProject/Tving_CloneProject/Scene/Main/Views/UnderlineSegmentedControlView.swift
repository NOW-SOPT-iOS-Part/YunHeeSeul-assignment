//
//  UnderLineSegmentedView.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/26/24.
//

import UIKit

import SnapKit
import Then

final class UnderlineSegmentedControlView: UISegmentedControl {
    
    // MARK: - UI Property
    
    private let underlineView = UIView()
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.removeBackgroundAndDivider()
        self.addSubview(underlineView)
    }

    override init(items: [Any]?) {
        super.init(items: items)
        self.removeBackgroundAndDivider()
        self.addSubview(underlineView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func moveUnderlineView(to index: Int) {
        
        underlineView.backgroundColor = UIColor(resource: .white)

        guard let text = self.titleForSegment(at: index),
                let font = UIFont(name: "Pretendard-Medium", size: 17)
        else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        let width = size.width
        let height = CGFloat(3)
        
        var xPosition: CGFloat
        var yPosition: CGFloat = self.frame.height - height
        
        switch index {
        case 0:
            xPosition = 15
            yPosition = 37
        case 1:
            xPosition = self.widthForSegment(at: 0) + 15
        case 2:
            xPosition = self.widthForSegment(at: 0) + self.widthForSegment(at: 1) + 15
        case 3:
            xPosition = self.widthForSegment(at: 0) + self.widthForSegment(at: 1) + self.widthForSegment(at: 2) + 15
        case 4:
            xPosition = self.widthForSegment(at: 0) + self.widthForSegment(at: 1) + self.widthForSegment(at: 2) + self.widthForSegment(at: 3) + 15
        default:
            xPosition = 15
        }
                
        UIView.animate(withDuration: 0.1) {
            self.underlineView.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        }
    }
}

// MARK: - private method

private extension UnderlineSegmentedControlView {
    
    func removeBackgroundAndDivider() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }

}
