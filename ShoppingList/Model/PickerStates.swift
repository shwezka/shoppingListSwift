//
//  PickerStates.swift
//  ShoppingList
//
//  Created by Тимофей Сухарев on 05.10.2026.
//

enum PickerStates: String, CaseIterable, Identifiable{
    case all
    case bought
    case needToBuy
    
    var id: Self { self }
}
