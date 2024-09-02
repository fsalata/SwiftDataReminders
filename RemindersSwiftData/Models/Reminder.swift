//
//  Reminders.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 02/09/24.
//

import Foundation
import SwiftData

@Model
class Reminder {
    var title: String
    var isCompleted: Bool
    var notes: String?
    var date: Date?
    var time: Date?

    var list: MyList?

    init(title: String, isCompleted: Bool = false, notes: String? = nil, date: Date? = nil, time: Date? = nil, list: MyList? = nil) {
        self.title = title
        self.isCompleted = isCompleted
        self.notes = notes
        self.date = date
        self.time = time
        self.list = list
    }
}
