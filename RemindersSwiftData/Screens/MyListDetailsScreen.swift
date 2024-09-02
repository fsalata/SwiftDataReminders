//
//  MyListDetailScreen.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 02/09/24.
//

import SwiftUI
import SwiftData

struct MyListDetailsScreen: View {
    let myList: MyList

    @Environment(\.modelContext) private var context

    @State private var title = ""
    @State private var isNewReminderAlertPresented = false
    @State private var selectedReminder: Reminder?
    @State private var showReminderEditScreen = false

    private let delay = Delay()

    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace
    }

    var body: some View {
        VStack {
            List {
                ForEach(myList.reminders.filter { !$0.isCompleted }) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                        switch event {
                        case let .onChecked(reminder, checked):
                            // cancel previous task
                            delay.cancel()
                            
                            // delay checked call
                            delay.performWork {
                                reminder.isCompleted = checked
                            }
                            
                        case let .onSelect(reminder):
                            selectedReminder = reminder
                            
                        case let .onInfoSelected(reminder):
                            showReminderEditScreen = true
                            selectedReminder = reminder
                        }
                    }
                }
                .onDelete { indexSet in
                    deleteReminder(indexSet)
                }
            }

            Spacer()

            Button {
                isNewReminderAlertPresented = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("New Reminder")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }

        }
        .navigationTitle(myList.name)
        .alert("Add new reminder", isPresented: $isNewReminderAlertPresented) {
            TextField("Title", text: $title)
            Button("Cancel", role: .cancel, action: {})
            Button("Done") {
                saveReminder()
                title = ""
            }
            .disabled(!isFormValid)
        }
        .sheet(isPresented: $showReminderEditScreen) {
            if let selectedReminder {
                NavigationStack {
                    ReminderEditScreen(reminder: selectedReminder)
                }
            }
        }
    }

    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        reminder.persistentModelID == selectedReminder?.persistentModelID
    }

    private func saveReminder() {
        let reminder = Reminder(title: title)

        myList.reminders.append(reminder)
    }

    private func deleteReminder(_ indexSet: IndexSet) {
        guard let index = indexSet.last else { return }

        let reminder = myList.reminders[index]

        context.delete(reminder)
    }
}

struct MyListDetailsScreenContainer: View {
    @Query private var myLists: [MyList]

    var body: some View {
        MyListDetailsScreen(myList: myLists[0])
    }
}

#Preview { @MainActor in
    NavigationStack {
        MyListDetailsScreenContainer()
    }
    .modelContainer(previewContainer)
}
