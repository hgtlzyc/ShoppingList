//
//  ItemController.swift
//  ShoppingList
//
//  Created by lijia xu on 7/23/21.
//

import Foundation

class ItemController {
    
    static let shared = ItemController()
    
    var items: [Item] = [Item(itemName: "check", isCompleted: true)]
    
    
    // MARK: - CRUD Functions
    
    func creatNewItem(name: String) {
        let newItem = Item(itemName: name)
        items.append(newItem)
        saveToDataStore()
    }
    
    func updateItem(item: Item, name: String, isComplete: Bool) {
        item.itemName = name
        item.isCompleted = isComplete
        saveToDataStore()
        
    }
    
    func deleteItem(_ item: Item) {
        guard let indexNeedsRemove = items.firstIndex(where: { $0 === item }) else { return }
        items.remove(at: indexNeedsRemove)
        saveToDataStore()
    }
    
    // MARK: - Data Store JSON
    
    func saveToDataStore(){
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: getURLForStore())
        } catch let e {
            print(e)
        }
        
    }
    
    func readFromDataStore(){
        do {
            let data = try Data(contentsOf: getURLForStore())
            items = try JSONDecoder().decode([Item].self, from: data)
        } catch let e {
            print(e)
        }
    }
    
    private func getURLForStore() -> URL {
        let documentDirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = documentDirURL[0].appendingPathComponent("ShoppingList.josn")
        return fileURL
    }
    
    
    // MARK: - Private Init method
    private init() {}
}
