//
//  CatalogController.swift
//  GBShop
//
//  Created by Игорь Андрианов on 17.04.2022.
//

import UIKit

final class CatalogController: UITableViewController {

    lazy var catalogService: CatalogDataRequestFactory = {
        let container = ContainerAssembly().makeContainer()
        let factory = RequestFactory(container: container)
        let catalogS = factory.makeCatalogDataRequestFaсtory()
        return catalogS
    }()
    private var products: [Product] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "productCell")
        fetchCatalog()
    }

    private func fetchCatalog() {
        catalogService.getCatalogData(pageNumber: 1, idCategory: 1) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                if result.result == 1 {
                    self.products = result.products ?? []
                } else {
                    print(result.errorMessage ?? "Какая-то ошибка")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
                as? ProductCell
        else { return UITableViewCell() }
        cell.configure(product: products[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30.0
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
            // Create a new instance of the appropriate class, insert it
     into the array, and add a new row to the table view
        }    
    }
    */
}
