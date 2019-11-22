//
//  AlertHelper.swift
//  CafeTek
//
//  Created by Tung on 10/25/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    static func showAlert(message: String, viewController: UIViewController?){
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        viewController?.present(alertController, animated: true, completion: nil)
    }
}

