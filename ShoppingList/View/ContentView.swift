//
//  ContentView.swift
//  ShoppingList
//
//  Created by Тимофей Сухарев on 05.10.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var items = ShoppingItem.samples
    @State private var searchText = ""
    @State private var showingAddItem = false
    @State private var pickerState = PickerStates.all

    private var visibleItems: [ShoppingItem] {
        return items.filter { item in
            let matchesState = switch pickerState {
            case .all:
                true
            case .bought:
                item.isPurchased
            case .needToBuy:
                !item.isPurchased
            }
            let matchesSearch =
            searchText.isEmpty
            || item.name.localizedStandardContains(searchText)
            || item.category.localizedStandardContains(searchText)
            
            return matchesSearch && matchesState
        }
    }
    
    @State private var showingFilter = false

    private var filterButton: some View {
        Button("Фильтр", systemImage: pickerState == .all
               ? "line.3.horizontal.decrease.circle"
               : "line.3.horizontal.decrease.circle.fill") {
            showingFilter = true
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if visibleItems.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                } else {
                    ForEach(visibleItems) { item in
                        NavigationLink(value: item.id) {
                            ShoppingItemRow(item: item) {
                                toggle(item)
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationTitle("Покупки")
            .searchable(text: $searchText, prompt: "Название или категория")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Добавить", systemImage: "plus") {
                        showingAddItem = true
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    filterButton
                }
                ToolbarSpacer(placement: .bottomBar)
                DefaultToolbarItem(kind: .search, placement: .bottomBar)
                ToolbarSpacer(placement: .bottomBar)
                
            }
            .sheet(isPresented: $showingAddItem) {
                AddShoppingItemView { newItem in
                    items.append(newItem)
                }
            }
            .sheet(isPresented: $showingFilter) {
                StatePicker(pickedState: $pickerState)
                    .presentationDetents([.medium])
            }
            .navigationDestination(for: UUID.self) { id in
                if let index = items.firstIndex(where: { $0.id == id }) {
                    ShoppingItemDetailView(item: $items[index])
                }
            }
        }
    }

    private func toggle(_ item: ShoppingItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        items[index].isPurchased.toggle()
    }

    private func delete(at offsets: IndexSet) {
        let ids = offsets.map { visibleItems[$0].id }
        items.removeAll { ids.contains($0.id) }
    }
}

#Preview {
    ContentView()
}
