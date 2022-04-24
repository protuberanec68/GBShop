//
//  RegisterController.swift
//  GBShop
//
//  Created by Игорь Андрианов on 16.04.2022.
//

import UIKit

final class RegisterController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var genderControl: UISegmentedControl!
    @IBOutlet weak var cardField: UITextField!
    @IBOutlet weak var bioField: UITextField!
    
    lazy var registerService: RegisterRequestFactory = {
        let container = ContainerAssembly().makeContainer()
        let factory = RequestFactory(container: container)
        let register = factory.makeRegisterRequestFaсtory()
        return register
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        guard let name = nameField.text,
              let password = passwordField.text,
              let email = emailField.text,
              let card = cardField.text,
              let userBio = bioField.text
        else {
            self.showOk(title: "Ошибка", message: "Что-то пошло не так")
            return
        }
        let genderIndex = genderControl.selectedSegmentIndex
        let userID = UUID().uuidString.hashValue
        let gender: Gender = genderIndex == 0 ? .male : .female
        let userData = UserData(
            id: userID,
            username: name,
            password: password,
            email: email,
            gender: gender,
            creditCard: card,
            bio: userBio)
        registerService.register(userData: userData) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response.result {
                case .success(let result):
                    if result.result == 1 {
                        EventLogger(event: .registrationSuccess)
                        self.showOk(title: "OK", message: "Вы зарегистрировались") {
                            self.dismiss(animated: true)
                        }
                    } else {
                        EventLogger(
                            event: .registrationFailure,
                            info: result.errorMessage ?? "Какая-то ошибка")
                        self.showOk(
                            title: "Error",
                            message: result.errorMessage ?? "Какая-то ошибка")
                    }
                case .failure(let error):
                    EventLogger(event: .registrationFailure, info: error.localizedDescription)
                    self.showOk(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
}
