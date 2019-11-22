//
//  ProfileVC.swift
//  CafeTek
//
//  Created by Tung on 9/28/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
import Stevia
import FirebaseAuth
class ProfileVC: UIViewController {

    let lblName = UILabel()
    let btnLogOut = UIButton()
    let tableView = UITableView()

    let imgMe = UIImageView(image: UIImage(named: "Me"))
    
    var profile = ["Payment Methor","Purchase History","Feedback","Setting"]
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        
        setupView()
        
        btnLogOut.addTarget(self, action: #selector(logout), for: .touchUpInside)

    }
    
    @objc func logout(){
        do {
            try Auth.auth().signOut()
            
            for vc in navigationController!.viewControllers {
                if let loginVC = vc as? LoginVC {
                    self.navigationController?.popToViewController(loginVC, animated: true)
                }
            }
            
 
        }
        catch{
            //print(error)
        }
        
    }
   
    func setupView(){
        view.sv(lblName,btnLogOut,tableView,imgMe)
 
        lblName.Top == view.safeAreaLayoutGuide.Top + 10
        btnLogOut.Top == view.safeAreaLayoutGuide.Top + 10
        imgMe.Top == view.safeAreaLayoutGuide.Top + 10
        view.layout(
            0,
            |-16-imgMe.size(44)-20-lblName-(>=20)-btnLogOut.width(100).height(50)-16-|,
            20,
            |tableView|,
            0
            
        )
        btnLogOut.setTitle("Log Out", for: .normal)
        btnLogOut.setTitleColor( .black, for: .normal)
        btnLogOut.backgroundColor = .clear
        btnLogOut.layer.cornerRadius = 10
        
        guard let username = Auth.auth().currentUser?.displayName else {return}
 
        lblName.text = "Hello \(username)"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationItem.hidesBackButton = true
        tabBarController?.navigationItem.title = "Profile"
    }


}
extension ProfileVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
       cell.textLabel?.text = profile[indexPath.row]
        cell.accessoryType = .disclosureIndicator
    
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let paymentVC = PaymentVC()
            navigationController?.pushViewController(paymentVC, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
}
