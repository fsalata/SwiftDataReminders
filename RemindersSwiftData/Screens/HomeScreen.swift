//
//  HomeScreen.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 28/08/24.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    @Environment(\.modelContext) private var context

    @Query private var myLists: [MyList]
    @Query private var reminders: [Reminder]

    @State private var isPresenting = false
    @State private var selectedList: MyList?
    @State private var sheetAction: HomeScreenSheetAction?
    @State private var selectedReminderStat: ReminderStatsType?
    @State private var search = ""

    private let statGridColumns = [
        GridItem(),
        GridItem()
    ]

    private var incompleteReminders: [Reminder] {
        reminders.filter { !$0.isCompleted }
    }

    private var todaysReminders: [Reminder] {
        incompleteReminders.filter { reminder in
            guard let reminderDate = reminder.date else {
                return false
            }

            return reminderDate.isToday
        }
    }

    private var scheduledReminders: [Reminder] {
        incompleteReminders.filter {
            $0.date != nil
        }
    }

    private var completeReminders: [Reminder] {
        reminders.filter { $0.isCompleted }
    }

    private var searchResults: [Reminder] {
        incompleteReminders.filter { $0.title.lowercased().contains(search.lowercased()) }
    }

    var body: some View {
        List {
            LazyVGrid(columns: statGridColumns, spacing: 8) {
                ForEach(ReminderStatsType.allCases) { stat in
                    ReminderStatsView(icon: stat.icon, title: stat.title, count: reminders(for: stat).count)
                        .onTapGesture {
                            selectedReminderStat = stat
                        }
                }
            }
            .listRowSeparator(.hidden)

            ForEach(myLists, id: \.self) { list in
                HStack {
                    NavigationLink(value: list) {
                        MyListCellView(list: list)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedList = list
                            }
                            .onLongPressGesture {
                                sheetAction = .edit(list: list)
                            }
                    }
                }
            }
            .onDelete { indexSet in
                deleteList(indexSet: indexSet)
            }

            Button {
                sheetAction = .new
            } label: {
                Text("Add list")
            }
            .foregroundStyle(.blue)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .searchable(text: $search)
        .overlay(alignment: .center, content: {
            if !search.isEmpty {
                ReminderListView(reminders: searchResults)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        })
        .navigationDestination(item: $selectedList, destination: { list in
            MyListDetailsScreen(myList: list)
        })
        .navigationDestination(item: $selectedReminderStat, destination: { stat in
            NavigationStack {
                ReminderListView(reminders: reminders(for: stat))
                    .navigationTitle(stat.title)
            }
        })
        .sheet(item: $sheetAction) { action in
            switch action {
            case .new:
                NavigationStack {
                    AddListScreen()
                }

            case .edit(let list):
                NavigationStack {
                    AddListScreen(list: list)
                }
            }
        }
        .navigationTitle("My List")
    }

    // MARK: Methods

    private func reminders(for statType: ReminderStatsType) -> [Reminder] {
        switch statType {
        case .today:
            todaysReminders
        case .scheduled:
            scheduledReminders
        case .all:
            incompleteReminders
        case .completed:
            completeReminders
        }
    }

    private func deleteList(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }

        let mylist = myLists[index]

        context.delete(mylist)
    }
}

// MARK: Enums
extension HomeScreen {
    enum HomeScreenSheetAction: Identifiable {
        case new
        case edit(list: MyList)

        var id: Int {
            switch self {
            case .new:
                return 0
            case .edit(let list):
                return list.hashValue
            }
        }
    }

    enum ReminderStatsType: Int, Identifiable, CaseIterable {
        case today
        case scheduled
        case all
        case completed

        var title: String {
            switch self {
            case .today:
                "Today"
            case .scheduled:
                "Scheduled"
            case .all:
                "All"
            case .completed:
                "Completed"
            }
        }

        var icon: String {
            switch self {
            case .today:
                "calendar"
            case .scheduled:
                "calendar.circle.fill"
            case .all:
                "tray.circle.fill"
            case .completed:
                "checkmark.circle.fill"
            }
        }

        var id: Int {
            self.rawValue
        }
    }
}

#Preview("Light Mode") { @MainActor in
    NavigationStack {
        HomeScreen()
    }
    .modelContainer(previewContainer)
}

#Preview("Dark Mode") { @MainActor in
    NavigationStack {
        HomeScreen()
    }
    .modelContainer(previewContainer)
    .preferredColorScheme(.dark)
}



