//
//  Item.swift
//  ShoppingList
//
//  Created by lijia xu on 7/23/21.
//

import Foundation


//class no need to conform equatable, can use ===
class Item: Codable {
    
    var itemName: String
    var isCompleted: Bool
    
    internal init(itemName: String, isCompleted: Bool = false) {
        self.itemName = itemName
        self.isCompleted = isCompleted
    }
    
}
