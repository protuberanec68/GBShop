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
    var currentProduct: Product?
    
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
        40.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentProduct = products[indexPath.row]
        performSegue(withIdentifier: "showProduct", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let productView = segue.destination as? ProductController,
              let product = currentProduct
        else { return }
        productView.product = product
    }
    
    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(
                style: .normal,
                title: "В корзину") { [weak self] (_, _, completionHandler) in
                    guard let self = self else { return }
                    self.addToCart(indexPath: indexPath)
                    completionHandler(true)
                }
            action.backgroundColor = .systemBlue
            return UISwipeActionsConfiguration(actions: [action])
        }
    
    private func addToCart(indexPath: IndexPath) {
        let product = products[indexPath.row]
        Cart.cart.addProduct(product: product)
        showToast(message: "Товар добавлен в корзину", font: .systemFont(ofSize: 12.0))
    }
}
