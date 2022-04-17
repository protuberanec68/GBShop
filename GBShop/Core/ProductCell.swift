//
//  ProductCell.swift
//  GBShop
//
//  Created by Игорь Андрианов on 17.04.2022.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(product: Product) {
        nameLabel.text = product.productName
        priceLabel.text = product.price.formatted(.currency(code: ""))
    }
}
