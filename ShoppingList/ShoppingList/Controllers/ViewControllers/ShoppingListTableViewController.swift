//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by lijia xu on 7/23/21.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.readFromDataStore()
    }
    
    // MARK: - AddNewItemRelated
    
    @IBAction func addNewItemPressed(_ sender: Any) {
        presentAddNewItemAlert()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }
        
        let itemForCell = ItemController.shared.items[indexPath.row]
        
        cell.updateViews(itemName: itemForCell.itemName, isComplete: itemForCell.isCompleted)
        cell.delegate = self

        return cell
    }
    

    // MARK: - Delete item related
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let itemToDelete = ItemController.shared.items[indexPath.row]
            ItemController.shared.deleteItem(itemToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

// MARK: - Alert

extension ShoppingListTableViewController {
    
    func presentAddNewItemAlert() {
        let alerVC = UIAlertController(title: "Add Item", message: "Please add an item to your shopping list ", preferredStyle: .alert)
        
        alerVC.addTextField { txField in
            txField.placeholder = "What do you need from the Store?"
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "add", style: .default) { _ in
            guard let itemName = alerVC.textFields?.first?.text, !itemName.isEmpty else { return }
            ItemController.shared.creatNewItem(name: itemName)
            self.tableView.reloadData()
        }
        alerVC.addAction(cancelAction)
        alerVC.addAction(addAction)
        
        present(alerVC, animated: true)
    }
    
    
}


// MARK: - Extension Protocol

extension ShoppingListTableViewController: ItemTableViewCellDelegate {
    
    func toggleItemStatus(_ cell: UITableViewCell) {

        guard let indexSelected = tableView.indexPath(for: cell) else { return }
        
        let itemNeedToggle = ItemController.shared.items[indexSelected.row]
        
        ItemController.shared.updateItem(item: itemNeedToggle, name: itemNeedToggle.itemName, isComplete: !itemNeedToggle.isCompleted)
        
        tableView.reloadData()
        
    }

}
