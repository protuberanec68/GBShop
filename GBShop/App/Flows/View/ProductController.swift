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
        tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "imageCell")

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "imageCell",
                for: indexPath) as? ImageCell
            else { return UITableViewCell()}
            cell.configure(image: UIImage(systemName: "cup.and.saucer.fill"))
            return cell
        }
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if indexPath.row == 1 {
            var content = cell.defaultContentConfiguration()
            content.text = product.productName
            cell.contentConfiguration = content
        } else {
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
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(
     _ tableView: UITableView,
     commit editingStyle: UITableViewCell.EditingStyle,
     forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {

        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
