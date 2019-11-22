//
//  Extension + UITextField.swift
//  CafeTek
//
//  Created by Tung on 9/25/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
   
    func setBottomBorder(color: CGColor,height: Double){
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0.0, height: height)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
