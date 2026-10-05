//
//  TypePicker.swift
//  ShoppingList
//
//  Created by Тимофей Сухарев on 05.10.2026.
//

import SwiftUI

struct StatePicker: View{
    @Binding var pickedState: PickerStates
    var body: some View {
        List {
            Picker("Все", selection: $pickedState) {
                Text("Куплено").tag(PickerStates.bought)
                Text("Надо купить").tag(PickerStates.needToBuy)
                Text("Все").tag(PickerStates.all)
            }
        }
    }
}

#Preview {
    @Previewable @State var pickerState = PickerStates.all
    StatePicker(pickedState: $pickerState)
}
