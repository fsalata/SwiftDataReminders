//
//  PreviewContainer.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 30/08/24.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
var previewContainer: ModelContainer = {
    let previewContainer = try!  ModelContainer(for: MyList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    for list in SampleData.myList {
        if list.name == "Groceries" {
            list.reminders = SampleData.reminders
        }

        previewContainer.mainContext.insert(list)
    }

    return previewContainer
}()

struct SampleData {
    static var myList: [MyList] = {
        [MyList(name: "Groceries", color: Color.green.toHex())]
    }()

    static var reminders: [Reminder] = {
        [Reminder(title: "Beer", notes: "Corona", date: Date(), time: Date()), Reminder(title: "Food", notes: "Steak", date: Date(), time: Date())]
    }()
}
