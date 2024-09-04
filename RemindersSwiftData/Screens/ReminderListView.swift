//
//  ReminderListView.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 03/09/24.
//

import SwiftUI
import SwiftData

struct ReminderListView: View {
    let reminders: [Reminder]

    @Environment(\.modelContext) private var context

    @State private var selectedReminder: Reminder? = nil

    @State var reminderDelays: [PersistentIdentifier: Delay] = [:]

    var body: some View {
        List {
            ForEach(reminders) { reminder in
                ReminderCellView(reminder: reminder) { event in
                    switch event {
                    case let .onChecked(reminder, checked):
                        if let delay = reminderDelays[reminder.persistentModelID] {
                            delay.cancel()
                            reminderDelays.removeValue(forKey: reminder.persistentModelID)
                        } else {
                            let delay = Delay(seconds: 0.5)
                            reminderDelays[reminder.persistentModelID] = delay

                            delay.performWork {
                                reminder.isCompleted = checked
                            }
                        }
                    case let .onSelect(reminder):
                        selectedReminder = reminder
                    }
                }
            }
            .onDelete { indexSet in
                deleteReminder(indexSet)
            }
        }
        .sheet(item: $selectedReminder) { reminder in
            NavigationStack {
                ReminderEditScreen(reminder: reminder)
            }
        }
    }

    private func deleteReminder(_ indexSet: IndexSet) {
        guard let index = indexSet.last else { return }

        let reminder = reminders[index]

        context.delete(reminder)
    }
}
