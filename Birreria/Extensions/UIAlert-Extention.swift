//
//  UIAlert-Extention.swift
//  Birreria
//
//  Created by Ossama Abdelwahab on 26/05/21.
//

import UIKit

extension UIViewController {
    func alert (title: String, message: String, preferredStyle: UIAlertController.Style, completion: @escaping ((Bool) -> Void)){
        
        var preferredStyleAlert =  preferredStyle
        if UIDevice.current.userInterfaceIdiom == .pad {
            preferredStyleAlert = .alert
        }
        else{
            preferredStyleAlert = preferredStyle
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyleAlert)
        alertController.addAction(UIAlertAction(title: "OK".uppercased(), style: .cancel, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
            completion(true)
        }))
        
        /*
         // Accessing alert view backgroundColor :
         alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = Config.white
         // Accessing buttons tintcolor :
         alertController.view.tintColor = Config.custom_Dark
         */
        
        self.present(alertController, animated: true, completion: nil)
    }
}
