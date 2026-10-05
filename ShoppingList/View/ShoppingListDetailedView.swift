//
//  ShoppingListDetailedView.swift
//  ShoppingList
//
//  Created by Тимофей Сухарев on 05.10.2026.
//

import SwiftUI

struct ShoppingItemDetailView: View {
    @Binding var item: ShoppingItem

    var body: some View {
        Form {
            TextField("Название", text: $item.name)
            TextField("Категория", text: $item.category)
            Stepper("Количество: \(item.quantity)", value: $item.quantity, in: 1...99)
            Toggle("Куплено", isOn: $item.isPurchased)
        }
        .navigationTitle("Покупка")
        .navigationBarTitleDisplayMode(.inline)
    }
}
