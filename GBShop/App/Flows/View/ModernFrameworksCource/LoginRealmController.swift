//
//  LoginRealmController.swift
//  GBShop
//
//  Created by Игорь Андрианов on 28.05.2022.
//

import UIKit
import RxCocoa
import RxSwift

class LoginRealmController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var onLogin: (() -> Void)?
    var onRegister: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        сonfigureFieldsObserver()
    }
    
    private func сonfigureFieldsObserver() {
        Observable
            .combineLatest(loginField.rx.text, passwordField.rx.text)
            .map { login, password in
                guard let login = login,
                      let password = password
                else { return false }
                return (!(login.isEmpty) && password.count > 3)
            }
            .bind { [weak loginButton] isCorrectInput in
                loginButton?.isEnabled = isCorrectInput
            }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let login = loginField.text,
              let users = try? RealmService.load(typeOf: UserRealm.self)
            .filter(NSPredicate(format: "login = %@", login)),
              let user = users.last,
              login == user.login
        else {
            print("wrong login")
            return
        }
        
        guard let password = passwordField.text,
              password == user.password
        else {
            print("wrong password")
            return
        }
        
        print("OK")
        UserDefaults.standard.set(true, forKey: "isLogin")
        onLogin?()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        onRegister?()
    }

}
