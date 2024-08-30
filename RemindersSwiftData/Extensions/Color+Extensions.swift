//
//  Color+Extensions.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 30/08/24.
//

import SwiftUI

extension Color {
    // Converts a Color to a hex string
    func toHex() -> String {
        let uiColor = UIColor(self)

        guard let components = uiColor.cgColor.components, components.count >= 3 else { return "" }

        let red = components[0]
        let green = components[1]
        let blue = components[2]

        let redInt = Int(red * 255)
        let greenInt = Int(green * 255)
        let blueInt = Int(blue * 255)

        return String(format: "#%02X%02X%02X", redInt, greenInt, blueInt)
    }

    // Initializes a Color from a hex string
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[index...])

            if hexColor.count == 6 {
                let r, g, b: CGFloat

                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber >> 16) & 0xFF) / 255.0
                    g = CGFloat((hexNumber >> 8) & 0xFF) / 255.0
                    b = CGFloat(hexNumber & 0xFF) / 255.0

                    self.init(red: r, green: g, blue: b)
                    return
                }
            }
        }

        return nil
    }
}
