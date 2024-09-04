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

    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace
    }

    var body: some View {
        VStack {
            ReminderListView(reminders: myList.reminders.filter { !$0.isCompleted })

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
        
    }

    private func saveReminder() {
        let reminder = Reminder(title: title)

        myList.reminders.append(reminder)
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
