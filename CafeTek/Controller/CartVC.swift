//
//  CartVC.swift
//  CafeTek
//
//  Created by Tung on 9/28/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
import Stevia



class CartVC: UIViewController {
    
    
    let tableView: UITableView = {
        let tv = UITableView()
        
        return tv
    }()
    
    let lblTotalPrice = UILabel()
    let btnOrder = UIButton()
    
    var carts: CartItem?
    
    var listShop  = CartItemManager()
 
     //var total = 0.0
    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Check Out"

        view.backgroundColor = .white
        
      

        tableView.delegate  = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(CartCell.self, forCellReuseIdentifier: "cartID")

       //createData()
        btnOrder.addTarget(self, action: #selector(order), for: .touchUpInside)
        
        
        listShop = appDelegate.myCart
        
        setupView()
        
        displayTotal()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      

    }
    func setupView(){
        view.sv(tableView,btnOrder,lblTotalPrice)
        tableView.Top == view.safeAreaLayoutGuide.Top
        view.layout(
            0,
            |tableView|,
            20,
            |-16-lblTotalPrice-16-|,
            20,
            |-16-btnOrder-16-| ~ 50,
            0
        )
        lblTotalPrice.font = UIFont.systemFont(ofSize: 20)
        btnOrder.Bottom == view.safeAreaLayoutGuide.Bottom

        lblTotalPrice.textAlignment = .center
        
        
        btnOrder.setTitle("Order", for: .normal)
        btnOrder.setTitleColor(.white, for: .normal)
        btnOrder.layer.cornerRadius = 10
        btnOrder.backgroundColor = UIColor(red: 185/255, green: 128/255, blue: 104/255, alpha: 1.0)
    }
    func displayTotal(){
        lblTotalPrice.text = "Total:  " + String(calculateCartTotal()) + " VND"
    }
    func  calculateCartTotal() -> Double {
        var total = 0.0

        if listShop.list.count > 0 {
            
            for index in 0..<listShop.list.count {
                
                total += Double(listShop.list[index].money)!
                print(total)
            }
        }

        
        return total
        
    }

    @objc func order(){
        if listShop.list.count > 0 {
        let alert = UIAlertController(title: "Check Out", message: "Check out success", preferredStyle: .alert)
        //add button
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
            for vc in self.navigationController!.viewControllers  {
                if let menuVC = vc as? UITabBarController{
                    self.navigationController?.popToViewController(menuVC, animated: true)

                }
            }
           
           
            
        }))
        //show alert
        self.present(alert, animated: true, completion: nil)
        }
        
        appDelegate.myCart.list.removeAll()
        
        
    }


}
extension CartVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  listShop.list.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartID", for: indexPath) as! CartCell
        
        cell.imgName.image = listShop.list[indexPath.row].imageName
        cell.lblName.text = listShop.list[indexPath.row].name
        cell.lblSize.text = listShop.list[indexPath.row].size
        cell.lblSugar.text = listShop.list[indexPath.row].sugar
        cell.lblAddtion.text = listShop.list[indexPath.row].addtions
        cell.lblQuanlity.text = listShop.list[indexPath.row].quanlity
        cell.lblMoney.text = listShop.list[indexPath.row].money
 
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            listShop.list.remove(at: indexPath.row)
            appDelegate.myCart.list.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()

            displayTotal()
        }
    }
    
}

