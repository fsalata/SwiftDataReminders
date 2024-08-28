//
//  AddListScreen.swift
//  RemindersSwiftData
//
//  Created by Fabio Salata on 28/08/24.
//

import SwiftUI

struct AddListScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var color: Color = .blue

    var body: some View {
        VStack {
            Image(systemName: "line.3.horizontal.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(color)

            HStack {
                TextField("Add list", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading], 44)

                ColorPicker("Color", selection: $color)
                    .pickerStyle(InlinePickerStyle())
                    .frame(width: 40, alignment: .center)
                    .labelsHidden()
                    .padding([.trailing], 44)
            }
        }
        .navigationTitle("New list")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Close")
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO
                } label: {
                    Text("Done")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddListScreen()
    }
}
