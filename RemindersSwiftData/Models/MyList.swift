//
//  MyList.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 30/08/24.
//

import Foundation
import SwiftData

@Model
final class MyList {
    var name: String
    var color: String

    @Relationship(deleteRule: .cascade)
    var reminders: [Reminder]

    init(name: String, color: String, reminders: [Reminder] = []) {
        self.name = name
        self.color = color
        self.reminders = reminders
    }
}
