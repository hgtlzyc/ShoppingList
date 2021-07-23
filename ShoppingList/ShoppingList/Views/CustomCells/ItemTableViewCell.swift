//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by lijia xu on 7/23/21.
//

import UIKit

protocol ItemTableViewCellDelegate: AnyObject {
    func toggleItemStatus(_ cell: UITableViewCell)
}


class ItemTableViewCell: UITableViewCell {
    
    weak var delegate: ItemTableViewCellDelegate?
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemStatusButton: UIButton!
    
    func updateViews(itemName: String, isComplete: Bool) {
        itemLabel.text = itemName
        let buttonImage = isComplete ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        itemStatusButton.setBackgroundImage(buttonImage, for: .normal)
    }
    
    
    @IBAction func itemStatusToggleTapped(_ sender: UIButton) {
        delegate?.toggleItemStatus(self)
    }
    
}
