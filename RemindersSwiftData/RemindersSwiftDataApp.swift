//
//  RemindersSwiftDataApp.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 28/08/24.
//

import SwiftUI
import UserNotifications

@main
struct RemindersSwiftDataApp: App {

    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeScreen()
            }
            .modelContainer(for: MyList.self)
        }
    }
}
