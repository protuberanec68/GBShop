//
//  ProductController.swift
//  GBShop
//
//  Created by Игорь Андрианов on 21.04.2022.
//

import UIKit

class ProductController: UITableViewController {

    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        tableView.register(
            UINib(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "buttonCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "imageCell",
                for: indexPath) as? ImageCell
            else { return UITableViewCell() }
            cell.configure(image: UIImage(systemName: "cup.and.saucer.fill"))
            return cell
        }
        if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "buttonCell",
                for: indexPath) as? ButtonCell
            else { return UITableViewCell() }
            cell.configure(title: "Добавить в корзину")
            return cell
        }
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if indexPath.row == 1 {
            var content = cell.defaultContentConfiguration()
            content.text = product.productName
            cell.contentConfiguration = content
        } else if indexPath.row == 2 {
            var content = cell.defaultContentConfiguration()
            content.text = product.price.formatted(.currency(code: ""))
            cell.contentConfiguration = content
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.view.frame.size.width - 20
        }
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if indexPath.row == 3 {
            Cart.cart.addProduct(product: product)
            showToast(message: "Товар добавлен в корзину", font: .systemFont(ofSize: 12.0))
        }
    }
}
