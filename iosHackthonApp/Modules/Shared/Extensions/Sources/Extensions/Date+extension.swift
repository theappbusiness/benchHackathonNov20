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
    static func dateFrom(_ timeIntervalString: String) -> Self {
        return Date(timeIntervalSince1970: Double(timeIntervalString) ?? 0)
    }

    static func readableDateString(from timeIntervalString: String) -> String {
        let formatDate = DateFormatter() // TODO: Cache formatters because they're expensive to create
        formatDate.dateFormat = Strings.Common.Date.nameDayMonth
        let drawDate = formatDate.string(from: dateFrom(timeIntervalString))
        return drawDate
    }
}
