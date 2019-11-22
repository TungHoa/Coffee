//
//  MenuVC.swift
//  CafeTek
//
//  Created by Tung on 9/28/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
import Stevia
import Firebase

class MenuVC: UIViewController {

    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(MenuCell.self, forCellReuseIdentifier: "cell")
        
        //tv.estimatedRowHeight = 80
        tv.rowHeight = UITableView.automaticDimension
        tv.tableFooterView = UIView()
        return tv
    }()
    
    var menus = [Menu]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        view.sv(tableView)
        tableView.Top == view.safeAreaLayoutGuide.Top + 10
        view.layout(
            0,
            |tableView|,
            0
        )
        tableView.dataSource = self
        tableView.delegate = self
 
        createData()
       
        
    }
   
    
    func createData(){
        let menu1 = Menu(imageName: "Espresso", name: "Espresso",money: "60")
        let menu2 = Menu(imageName: "Cappuccino", name: "Cappuccino", money: "70")
        let menu3 = Menu(imageName: "Macciato", name: "Macciato", money: "50")
        let menu4 = Menu(imageName: "Mocha", name: "Mocha", money: "55")
        let menu5 = Menu(imageName: "Latte", name: "Latte", money: "45")
        
        menus = [menu1,menu2,menu3,menu4,menu5]
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.navigationBar.isHidden = true
        tabBarController?.navigationItem.hidesBackButton = true
        tabBarController?.navigationItem.title = "Menu"
    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = false
//    }
//

}
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCell
        
        cell.accessoryType = .disclosureIndicator
       
        
        cell.imageMenu.image = UIImage(named: menus[indexPath.row].imageName)
        cell.lblTitle.text = menus[indexPath.row].name
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let choiceVC = ChoiceVC()
        choiceVC.createInit(imageName: menus[indexPath.row].imageName, textName: menus[indexPath.row].name, money: menus[indexPath.row].money)
        
        tabBarController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationController?.pushViewController(choiceVC, animated: true)
        
        
    }
    
    
}
