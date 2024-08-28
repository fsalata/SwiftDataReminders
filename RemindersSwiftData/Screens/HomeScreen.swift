//
//  HomeScreen.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 28/08/24.
//

import SwiftUI

struct HomeScreen: View {

    @State private var isPresenting = false

    let myList = ["Groceries", "Fun", "Code", "Work"]

    var body: some View {
        List {
            Text("My Lists")
                .font(.largeTitle)
                .fontWeight(.bold)

            ForEach(myList, id: \.self) { list in
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .font(.system(size: 32))

                    Text(list)
                }
            }

            Button {
                isPresenting = true
            } label: {
                Text("Add list")
            }
            .foregroundStyle(.blue)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .sheet(isPresented: $isPresenting) {
            NavigationStack {
                AddListScreen()
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeScreen()
    }
}
