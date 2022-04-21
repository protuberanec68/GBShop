//
//  ImageCell.swift
//  GBShop
//
//  Created by Игорь Андрианов on 21.04.2022.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var imageProd: UIImageView!
//    private var curImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: UIImage?) {
        imageProd.image = image
    }
    
}
