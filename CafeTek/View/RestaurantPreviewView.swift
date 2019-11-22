//
//  RestaurantPreviewView.swift
//  CafeTek
//
//  Created by Tung on 10/20/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import Foundation
import UIKit

class RestaurantPreviewView: UIView {
    
    let containerView: UIView = {
        let v=UIView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let imgView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "header")
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.boldSystemFont(ofSize: 28)
        lbl.textColor = UIColor.black
        lbl.backgroundColor = UIColor.white
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        setupViews()
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        
        containerView.addSubview(lblTitle)
        lblTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive=true
        lblTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive=true
        lblTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 35).isActive=true
        
        addSubview(imgView)
        imgView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        imgView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive=true
        imgView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        imgView.contentMode = .scaleAspectFit
        
    }
    func setData(title: String, img: UIImage) {
        lblTitle.text = title
        imgView.image = img
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
