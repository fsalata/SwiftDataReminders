//
//  PreviewContainer.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 30/08/24.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
var previewContainer: ModelContainer = {
    let previewContainer = try!  ModelContainer(for: MyList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    for list in SampleData.myList {
        previewContainer.mainContext.insert(list)
    }

    return previewContainer
}()

struct SampleData {
    static var myList: [MyList] = {
        [MyList(name: "Groceries", color: Color.green.toHex()), MyList(name: "Business", color: Color.red.toHex())]
    }()
}
