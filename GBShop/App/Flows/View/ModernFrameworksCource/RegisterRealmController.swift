//
//  RegisterRealmController.swift
//  GBShop
//
//  Created by Игорь Андрианов on 28.05.2022.
//

import UIKit

class RegisterRealmController: UIViewController {
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        guard let login = loginField.text,
              let password = passwordField.text
        else {
            print("something wrong")
            return
        }

        let newUser = UserRealm(login: login, password: password)
        do {
            try RealmService.save(items: [newUser])
            print("OK")
            dismiss(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }

}
