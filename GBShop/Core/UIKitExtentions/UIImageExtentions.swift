//
//  UIImageExtentions.swift
//  GBShop
//
//  Created by Игорь Андрианов on 13.06.2022.
//

import UIKit

extension UIImage {
    func resized(to newWidth: CGFloat) -> UIImage {
        let scale = self.size.width / newWidth
        let newHeight = self.size.height / scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
