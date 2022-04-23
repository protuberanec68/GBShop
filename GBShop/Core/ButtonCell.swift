//
//  ButtonCell.swift
//  GBShop
//
//  Created by Игорь Андрианов on 23.04.2022.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
