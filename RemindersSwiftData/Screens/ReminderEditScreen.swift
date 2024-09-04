//
//  ReminderEditScreen.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 02/09/24.
//

import SwiftUI
import SwiftData

struct ReminderEditScreen: View {
    var reminder: Reminder

    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var notes = ""
    @State private var date: Date = .now
    @State private var time: Date = .now
    @State private var showCalendar = false
    @State private var showTime = false

    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace
    }

    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
                TextField("Notes", text: $notes)
            }

            Section {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(.red)
                        .font(.title2)

                    Toggle(isOn: $showCalendar) {
                        EmptyView()
                    }
                }

                if showCalendar {
                    DatePicker("Select date", selection: $date, in: Date.now..., displayedComponents: .date)
                }

                HStack {
                    Image(systemName: "clock")
                        .foregroundStyle(.blue)
                        .font(.title2)

                    Toggle(isOn: $showTime) {
                        EmptyView()
                    }
                }
                .onChange(of: showTime) {
                    if showTime {
                        showCalendar = true
                    }
                }

                if showTime {
                    DatePicker("Select date", selection: $time, displayedComponents: .hourAndMinute)
                }
            }
        }
        .onAppear {
            title = reminder.title
            notes = reminder.notes ?? ""
            date = reminder.date ?? .now
            time = reminder.time ?? .now
            showCalendar = reminder.date != nil
            showTime = reminder.time != nil
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Close")
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    updateReminder()
                    dismiss()
                } label: {
                    Text("Done")
                }
                .disabled(!isFormValid)
            }
        }
    }

    private func updateReminder() {
        reminder.title = title
        reminder.notes = notes.isEmpty ? nil : notes
        reminder.date = showCalendar ? date : nil
        reminder.time = showTime ? time : nil

        NotificationManager.scheduleNotification(userData: UserData(title: title, body: reminder.notes, date: reminder.date, time: reminder.time))
    }
}

struct ReminderEditScreenContainer: View {
    @Query private var reminders: [Reminder]

    var body: some View {
        ReminderEditScreen(reminder: reminders[0])
    }
}

#Preview { @MainActor in
    NavigationStack {
        ReminderEditScreenContainer()
    }
    .modelContainer(previewContainer)
}
