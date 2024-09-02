//
//  Date+Extensions.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 02/09/24.
//

import Foundation

extension Date {
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }

    var isTomorrow: Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(self)
    }
}
