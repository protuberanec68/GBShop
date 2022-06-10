//
//  UserDataController.swift
//  GBShop
//
//  Created by Игорь Андрианов on 16.04.2022.
//

import UIKit

final class UserDataController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var cardField: UITextField!
    @IBOutlet weak var bioField: UITextField!
    
    lazy var changeService: ChangeDataRequestFactory = {
        let container = ContainerAssembly().makeContainer()
        let factory = RequestFactory(container: container)
        let change = factory.makeChangeDataRequestFaсtory()
        return change
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveDataTapped(_ sender: Any) {
        guard let name = loginField.text,
              let password = passwordField.text,
              let email = emailField.text,
              let card = cardField.text,
              let bioData = bioField.text,
              let curUser = CurrentUser.shared.user
        else {
            self.showOk(title: "Ошибка", message: "Что-то пошло не так")
            
            return
        }
        if name.isEmpty || password.isEmpty {
            self.showOk(
                title: "Ошибка",
                message: "Поля логин и пароль должны быть заполнены")
            return
        }
        let userData = UserData(
            id: curUser.id,
            username: name,
            password: password,
            email: email,
            gender: .male,
            creditCard: card,
            bio: bioData
        )
        changeService.changeUserData(userData: userData) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response.result {
                case .success(let result):
                    if result.result == 1 {
                        self.showOk(title: "Успешно", message: "Данные изменены")
                    } else {
                       self.showOk(
                            title: "Ошибка",
                            message: result.errorMessage ?? "Неизвестная ошибка")
                    }
                case .failure(let error):
                    self.showOk(title: "Ошибка", message: error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
