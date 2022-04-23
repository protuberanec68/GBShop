//
//  ProductCartCell.swift
//  GBShop
//
//  Created by Игорь Андрианов on 23.04.2022.
//

import UIKit

class ProductCartCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = ""
        quantityLabel.text = ""
        priceLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(product: ProductWithQuantity) {
        nameLabel.text = product.product.productName
        quantityLabel.text = String(product.quantity)
        priceLabel.text = (Decimal(product.quantity) * product.product.price)
            .formatted(.currency(code: ""))
    }
}
