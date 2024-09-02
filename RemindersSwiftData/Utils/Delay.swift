//
//  Delay.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 02/09/24.
//

import Foundation

class Delay {
    private var seconds: Double
    var workItem: DispatchWorkItem?

    init(seconds: Double = 2.0) {
        self.seconds = seconds
    }

    func performWork(_ work: @escaping () -> Void) {
        workItem = DispatchWorkItem(block: {
            work()
        })

        if let workItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem)
        }
    }

    func cancel() {
        workItem?.cancel()
    }
}
