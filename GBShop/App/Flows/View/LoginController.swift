//
//  LoginController.swift
//  GBShop
//
//  Created by Игорь Андрианов on 16.04.2022.
//

import UIKit

final class LoginController: UIViewController {
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    lazy var authService: AuthRequestFactory = {
        let container = ContainerAssembly().makeContainer()
        let factory = RequestFactory(container: container)
        let auth = factory.makeAuthRequestFaсtory()
        return auth
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let name = loginField.text,
              let password = passwordField.text,
              !name.isEmpty,
              !password.isEmpty
        else {
            self.showOk(
                title: "Ошибка",
                message: "Логин/пароль не заполнены")
            return
        }
        authService.login(userName: name, password: password) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response.result {
                case .success(let result):
                    guard result.result == 1,
                          let user = result.user
                    else {
                        self.showOk(
                            title: "Ошибка",
                            message: result.errorMessage ?? "Неизвестная ошибка")
                        self.passwordField.text = ""
                        return
                    }
                    CurrentUser.shared.user = user
                    self.passwordField.text = ""
                    self.performSegue(withIdentifier: "goMain", sender: nil)
                case .failure(let error):
                    self.showOk(
                        title: "Ошибка",
                        message: error.localizedDescription)
                }
            }
        }
    }
}
