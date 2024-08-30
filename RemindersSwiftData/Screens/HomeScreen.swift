//
//  HomeScreen.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 28/08/24.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {

    @Query private var myLists: [MyList]

    @State private var isPresenting = false

    var body: some View {
        List {
            Text("My Lists")
                .font(.largeTitle)
                .fontWeight(.bold)

            ForEach(myLists, id: \.self) { list in
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(Color(hex: list.color) ?? .black)

                    Text(list.name)
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

#Preview { @MainActor in
    NavigationStack {
        HomeScreen()
    }
    .modelContainer(previewContainer)
}
