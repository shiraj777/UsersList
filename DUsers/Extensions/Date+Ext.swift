//
//  Date+Ext.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import Foundation
import Foundation


extension Date {
  
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}
