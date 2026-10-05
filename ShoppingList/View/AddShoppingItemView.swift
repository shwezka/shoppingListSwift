//
//  AddShoppingItemView.swift
//  ShoppingList
//
//  Created by Тимофей Сухарев on 05.10.2026.
//

import SwiftUI

struct AddShoppingItemView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var category = ""
    @State private var quantity = 1

    let onSave: (ShoppingItem) -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField("Название", text: $name)
                TextField("Категория", text: $category)
                Stepper("Количество: \(quantity)", value: $quantity, in: 1...99)
            }
            .navigationTitle("Новая покупка")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        let item = ShoppingItem(
                            name: name,
                            category: category,
                            quantity: quantity
                        )
                        onSave(item)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
