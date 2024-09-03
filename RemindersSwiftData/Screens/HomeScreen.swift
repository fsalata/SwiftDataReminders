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
    @State private var selectedList: MyList?
    @State private var sheetAction: HomeScreenSheetAction?

    var body: some View {
        List {
            Text("My Lists")
                .font(.largeTitle)
                .fontWeight(.bold)

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
        .navigationDestination(item: $selectedList, destination: { list in
            MyListDetailsScreen(myList: list)
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
    }
}

// MARK: Navigation sheet actions
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
}

#Preview { @MainActor in
    NavigationStack {
        HomeScreen()
    }
    .modelContainer(previewContainer)
}


