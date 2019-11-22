//
//  Cart.swift
//  CafeTek
//
//  Created by Tung on 10/7/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import Foundation
import UIKit

class CartItem {
    var imageName: UIImage
    var name: String
    var size:String
    var sugar: String
    var addtions: String
    var money: String
    var quanlity: String
    
    
    init(imageName: UIImage,name: String,size:String,sugar:String,addtions:String,money:String,quanlity:String) {
        self.imageName = imageName
        self.name = name
        self.size = size
        self.sugar = sugar
        self.addtions = addtions
        self.money = money
        self.quanlity = quanlity
        
        
    }
}

struct CartItemManager {
    var list = [CartItem]()
 
}
