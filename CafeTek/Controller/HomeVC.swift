//
//  HomeVC.swift
//  CafeTek
//
//  Created by Tung on 9/24/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
import Stevia
class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "bg")
        backgroundImage.contentMode = .scaleToFill

        
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "logo")
        iconImage.contentMode = .scaleToFill
        iconImage.center = view.center

        
        
        view.sv(backgroundImage,iconImage)
        
        //backgroundImage.Top == view.safeAreaLayoutGuide.Top
        view.layout(
            0,
            |backgroundImage|,
            0
        )
        
        iconImage.centerVertically().centerHorizontally().size(150)
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(gestureTap(gesture:)))
        
        view.addGestureRecognizer(gestureTap)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
   
    @objc func gestureTap(gesture:UITapGestureRecognizer){
        let onBoard = OnBoarding()
        
        navigationController?.pushViewController(onBoard, animated: true)
        
    }
    

}
