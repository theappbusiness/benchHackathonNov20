//
//  Date+extension.swift
//  iosHackthonApp
//
//  Created by Gareth Miller on 12/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import Foundation
import Strings

public extension Date {
    static func dateFrom(dateString: String) -> Self {
        let dateFormatter = DateFormatter() // TODO: Cache formatters because they're expensive to create
        dateFormatter.dateFormat = Strings.Common.Date.americanFormat
        return dateFormatter.date(from: dateString) ?? Date()
    }

    static func readableDateString(from dateString: String) -> String {
        let formatDate = DateFormatter()
        formatDate.dateFormat = Strings.Common.Date.nameDayMonth
        let drawDate = formatDate.string(from: dateFrom(dateString: dateString))
        return drawDate
    }
}
