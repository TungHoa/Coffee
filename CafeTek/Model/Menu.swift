//
//  Menu.swift
//  CafeTek
//
//  Created by Tung on 9/28/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import Foundation
import UIKit

class Menu {
    var imageName: String
    var name: String
    var money: String
    
    init(imageName: String,name: String,money:String) {
        self.imageName = imageName
        self.name = name
        self.money = money
    }
}
