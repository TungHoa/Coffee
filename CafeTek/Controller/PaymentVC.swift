//
//  PaymentVC.swift
//  CafeTek
//
//  Created by Tung on 11/2/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
import Stevia
class PaymentVC: UIViewController {
    
    
    let mainView = UIView()
    let lblText = UILabel()
    
   
    
    lazy var segmentedControl: UISegmentedControl = {
       let control  = UISegmentedControl(items: ["Money","Card"])
        
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        setupView()

       
    }
    
    func setupView(){
        view.sv(
            mainView.sv(
                lblText,
                segmentedControl
            )
        )
        
        mainView.Top == view.safeAreaLayoutGuide.Top + 20
        view.layout(
            0,
            |-16-mainView-16-| ~ 150,
            (>=20)
            
        )
        
        mainView.layout(
            20,
            |-16-lblText-(>=16)-|,
            20,
            |-16-segmentedControl-16-| ~ 40,
            (>=20)
            
        )
        lblText.text = "Currently paying with"
        mainView.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

  

}
