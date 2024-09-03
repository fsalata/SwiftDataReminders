//
//  MyListCellView.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 03/09/24.
//

import SwiftUI

struct MyListCellView: View {
    let list: MyList

    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .font(.system(size: 32))
                .foregroundStyle(Color(hex: list.color) ?? .black)
            
            Text(list.name)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
