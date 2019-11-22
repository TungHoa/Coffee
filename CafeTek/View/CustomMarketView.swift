//
//  CustomMarketView.swift
//  CafeTek
//
//  Created by Tung on 10/20/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class CustomMarketView : UIView {
    var img: UIImage!
    var borderColor: UIColor!
    
    
    init(frame:CGRect,image: UIImage,tag:Int){
        super.init(frame: frame)
        self.img = image
        self.tag = tag
        
        setupView()
    }
    
    func setupView(){
        let imgView = UIImageView(image: img)
        imgView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)

        let lbl = UILabel(frame: CGRect(x: 0, y: 45, width: 50, height: 10))
        lbl.text = "▾"
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.textColor = borderColor
        lbl.textAlignment  = .center
        
        self.addSubview(imgView)
        self.addSubview(lbl)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
