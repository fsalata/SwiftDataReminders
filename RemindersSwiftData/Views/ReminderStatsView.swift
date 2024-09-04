//
//  ReminderStatsView.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 03/09/24.
//

import SwiftUI

struct ReminderStatsView: View {
    let icon: String
    let title: String
    let count: Int

    var body: some View {
        GroupBox {
            HStack {
                VStack(spacing: 10) {
                    Image(systemName: icon)
                    Text(title)
                }

                Spacer()

                Text("\(count)")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ReminderStatsView(icon: "calendar", title: "Today", count: 9)
}
