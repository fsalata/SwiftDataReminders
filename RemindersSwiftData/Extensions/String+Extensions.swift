//
//  String+Extensions.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 02/09/24.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
