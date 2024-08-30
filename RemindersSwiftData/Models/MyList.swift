//
//  MyList.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 30/08/24.
//

import Foundation
import SwiftData

@Model
final class MyList {
    var name: String
    var color: String

    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
}
