//
//  ExtensionViewController.swift
//  RecipeBook
//
//  Created by Admin on 29.11.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: false, completion: nil)
    }
}
