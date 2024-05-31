//
//  String+.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 5/31/24.
//

import Foundation

extension String {
    
    static func calculateDate() -> String {
        let today = Date()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = -1

        if let oneDayAgo = calendar.date(byAdding: dateComponents, to: today) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            
            let oneDayAgoString = dateFormatter.string(from: oneDayAgo)
            return oneDayAgoString
        } else {
            return ""
        }
    }
}
