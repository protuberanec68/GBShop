//
//  CartController.swift
//  GBShop
//
//  Created by Игорь Андрианов on 23.04.2022.
//

import UIKit

class CartController: UITableViewController {

    lazy var basketService: BasketRequestFactory = {
        let container = ContainerAssembly().makeContainer()
        let factory = RequestFactory(container: container)
        let basket = factory.makeBasketRequestFactory()
        return basket
    }()
    
    var products: [ProductWithQuantity] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(nibName: "ProductCartCell", bundle: nil), forCellReuseIdentifier: "productCartCell")
        tableView.register(
            UINib(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "buttonCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        products = Cart.cart.productsWithQuantity()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count + 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == products.count {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            var content = cell.defaultContentConfiguration()
            content.text = "Общая стоимость покупки: " + Cart.cart.totalCost().formatted(.currency(code: ""))
            cell.contentConfiguration = content
            return cell
        } else if indexPath.row == products.count + 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "buttonCell",
                for: indexPath) as? ButtonCell
            else { return UITableViewCell() }
            cell.configure(title: "Купить")
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCartCell") as? ProductCartCell
        else { return UITableViewCell() }
        cell.configure(product: products[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if indexPath.row == products.count + 1 {
            buyProducts()
        }
    }
    
    func buyProducts() {
        basketService.payBasket(
            basketProducts: Cart.cart.basket(),
            userID: CurrentUser.shared.user?.id ?? 0) { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch response.result {
                    case .success(let result):
                        
                        if result.result == 1 {
                            Cart.cart.clearCart()
                            EventLogger(event: .payBasket)
                            self.showOk(title: "Успешно", message: "Покупка совершена") {
                                self.tabBarController?.selectedIndex = 1
                            }
                        } else {
                            self.showOk(title: "Ошибка", message: result.errorMessage ?? "Какая-то ошибка")
                        }
                    case .failure(let error):
                        self.showOk(title: "Ошибка", message: error.localizedDescription)
                    }
                }
            }
    }
}
