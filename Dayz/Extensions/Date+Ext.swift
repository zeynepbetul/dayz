//
//  Date+Ext.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 18.12.2025.
//

import Foundation

extension Date {
    
    func convertMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyy"
        return dateFormatter.string(from: self)
    }
}
