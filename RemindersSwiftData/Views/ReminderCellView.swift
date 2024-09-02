//
//  ReminderCellView.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 02/09/24.
//

import SwiftUI
import SwiftData

enum ReminderCellEvents {
    case onChecked(Reminder, Bool)
    case onSelect(Reminder)
    case onInfoSelected(Reminder)
}

struct ReminderCellView: View {
    let reminder: Reminder
    var isSelected = false
    let onEvent: (ReminderCellEvents) -> Void

    @State private var checked = false

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName:  checked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .padding([.trailing], 5)
                .onTapGesture {
                    checked.toggle()
                    
                    onEvent(.onChecked(reminder, checked))
                }

            VStack {
                Text(reminder.title)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let notes = reminder.notes {
                    Text(notes)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                HStack {
                    if let date = reminder.date {
                        Text(formatReminderDate(date))
                    }

                    if let time = reminder.time {
                        Text(time, style: .time)
                    }
                }
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1 : 0)
                .onTapGesture {
                    onEvent(.onInfoSelected(reminder))
                }

        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.onSelect(reminder))
        }
    }

    // TODO: create date formatter for Text
    private func formatReminderDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        }

        return date.formatted(date: .abbreviated, time: .omitted)
    }
}

struct ReminderCellViewContainer: View {
    @Query(sort: \Reminder.time) private var reminders: [Reminder]

    var body: some View {
        ReminderCellView(reminder: reminders[0], onEvent: { _ in })
    }
}

#Preview { @MainActor in
    NavigationStack {
        ReminderCellViewContainer()
            .modelContainer(previewContainer)
    }
}
