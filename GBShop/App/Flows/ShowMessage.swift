//
//  ShowMessage.swift
//  GBShop
//
//  Created by Игорь Андрианов on 17.04.2022.
//

import UIKit

final class ShowMessage {
    
    /**
     Must execute in main queue
     */
    func showOk(
        sender: UIViewController,
        title: String,
        message: String,
        actionAfterTapOK: @escaping (() -> Void) = {}) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .destructive) {_ in
                actionAfterTapOK()
            }
            alert.addAction(action)
            sender.present(alert, animated: true)
        }
}
