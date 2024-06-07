//
//  SelectedButtonStatus.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 6/6/24.
//

import UIKit

protocol SelectedButtonStatus {
    
    var bgColor: UIColor { get }
    
    var isSelected: Bool { get }
    
}
//
//struct SelectedPageControlButton: SelectedButtonStatus {
//    
//    var bgColor: UIColor = UIColor(resource: .white)
//    
//    var isSelected: Bool = true
//    
//}
//
//struct NotSelectedPageControlButton: SelectedButtonStatus {
//    
//    var bgColor: UIColor = UIColor(resource: .grey3)
//    
//    var isSelected: Bool = false
//    
//}
