//
//  ExtensionViewController.swift
//  AlboTest
//
//  Created by Mauricio Rodriguez on 10/04/21.
//

import Foundation
import UIKit

extension UIViewController {
    /** Show a simple message
        - Parameters:
            - titleStr: Title for the message
            - messageStr: A little description for the message
    */
    func showAlertMessage(titleStr:String, messageStr:String) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
