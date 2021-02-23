//
//  UIViewController+Extension.swift
//  Assessment
//
//  Created by Hitesh on 23/02/21.
//

import UIKit

extension UIViewController {
    func showAlert(title:String = "Alert",message:String, completion:(() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true) {
                completion?()
            }
        }        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
