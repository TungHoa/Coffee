//
//  ChoiceVC.swift
//  CafeTek
//
//  Created by Tung on 9/29/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
import Stevia


extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: angle)
    }
}

class ChoiceVC: UIViewController {
    


    let scrollView: UIScrollView = {
       let sv = UIScrollView()
        
        return sv
    }()
    let containerView = UIView()
    //top view
    let imageBG: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "header")
        
        return image
    }()
    
    let imageIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Macciato")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let lblName = UILabel()
    let lblPrice = UILabel()
    let lblAmount = UILabel()
    let btnQuanlity = UIStepper()
    
    //Size
    let lblTitleSize = UILabel()
    let stackViewSize: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        
        return sv
    }()
    let btnSize1 = UIButton()
    let btnSize2 = UIButton()
    let btnSize3 = UIButton()
    
    //Sugar
    
    let lblTitleSugar = UILabel()
    let stackViewSugar: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        //sv.distribution = .fillEqually
        
        return sv
    }()
    let btnSugar1 = UIButton()
    let btnSugar2 = UIButton()
    let btnSugar3 = UIButton()
    let btnSugar4 = UIButton()
    
    //Addtions
    let lblTitleAdd = UILabel()
    let stackViewAdd: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        
        
        return sv
    }()
    let btnAdd1 = UIButton()
    let btnAdd2 = UIButton()
    
    //add tocart
    let lblTotal = UILabel()
    let lblTotalPrice = UILabel()
    let lblVND = UILabel()
    let btnCart = UIButton()
    
    //

    var imageName: String!
    var textName : String!
    var money: String!
    
    
    var originalPrice: Double?
    var subTotalPrice: Double? = 0.0
    var totalPrice: Double = 0.0
    var quantity: Int = 1
    
    var itemAddToCart = CartItemManager()
    

    let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    let label = UILabel(frame: CGRect(x: 15, y: -10, width: 20, height: 18))
    
    var counterItem = 0
    
    var lastSelectedButton: UIButton!
    
    var typeSize: String!
    var typeSugar: String!
    var typeAddtions: String!
    
   
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Preferences"
        view.backgroundColor = .white
        // badge label
        
        
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = UIFont(name: "SanFranciscoText-Light", size: 10)
        
        label.textColor = .white
        label.backgroundColor = .red
        //label.text = "5"
        //label.isHidden = true
        
       
        rightButton.setBackgroundImage(UIImage(named: "ic_cart"), for: .normal)
        rightButton.addTarget(self, action: #selector(cartButton), for: .touchUpInside)
        rightButton.addSubview(label)
 
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
       
        view.backgroundColor = .white

        addControl()
        setupView()

        btnSize1.addTarget(self, action: #selector(btnSelected), for: .touchUpInside)
        btnSize2.addTarget(self, action: #selector(btnSelected), for: .touchUpInside)
        btnSize3.addTarget(self, action: #selector(btnSelected), for: .touchUpInside)
        
       
        btnQuanlity.addTarget(self, action: #selector(updateStepper(_:)), for: .touchUpInside)
        btnQuanlity.minimumValue = 1

        btnCart.addTarget(self, action: #selector(addItemToCart), for: .touchUpInside)
        
        
        
       btnSize1.isSelected = true
       
    

    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.label.text = "\(appDelegate.myCart.list.count)"
 
    }

  
    @objc func addItemToCart(){
        
        
        // add to cart
       

        guard let image = imageIcon.image, let product = lblName.text, let size = typeSize, let sugar = typeSugar, let addtions = typeAddtions, let total = lblTotalPrice.text, let soluong = lblAmount.text else {
            
            if typeSize == nil {
                let btnArraySize = [btnSize1,btnSize2,btnSize3]
                for i in btnArraySize {
                    i.shake()
                }
            }
            
            if typeSugar == nil {
                let btnArraySugar = [btnSugar1,btnSugar2,btnSugar3,btnSugar4]
                for i in btnArraySugar {
                    i.shake()
                }
            }
            
            if typeAddtions == nil {
                let btnArrayAddtions = [btnAdd1,btnAdd2]
                for i in btnArrayAddtions {
                    i.shake()
                }
            }
            return
            
            
        }
            
        

        let cartItem = CartItem(imageName: image, name: product, size: size, sugar: sugar, addtions: addtions, money: total, quanlity: soluong)

        appDelegate.myCart.list.append(cartItem)
 
        //fly cart animation
        DispatchQueue.main.async {
            let imageViewPosition : CGPoint = self.imageIcon.convert(self.imageIcon.bounds.origin, to: self.view)
            let imgViewTemp = UIImageView(frame: CGRect(x:imageViewPosition.x , y: imageViewPosition.y, width: self.imageIcon.frame.size.width, height: self.imageIcon.frame.size.height))
            
            imgViewTemp.image = self.imageIcon.image
            
            self.animation(tempView: imgViewTemp)
           
        }
        

    }
    func animation(tempView : UIView)  {
        self.view.addSubview(tempView)
        UIView.animate(withDuration: 1.0,
                       animations: {
                        
                        tempView.animationZoom(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
         
            UIView.animate(withDuration: 0.5, animations: {

                
                DispatchQueue.main.async {
                    tempView.animationZoom(scaleX: 0.2, y: 0.2)
                }
                
                tempView.animationRoted(angle: CGFloat.pi )

                tempView.frame.origin.x = self.rightButton.frame.origin.x + (self.view.frame.size.width - self.rightButton.frame.origin.x - 20)
                tempView.frame.origin.y = self.rightButton.frame.origin.y

            }, completion: { _ in
                
                tempView.removeFromSuperview()
                
                UIView.animate(withDuration: 1.0, animations: {

                    //self.counterItem += 1
                    self.label.text = "\(self.appDelegate.myCart.list.count)"
                    
                    
                    //self.rightButton.animationZoom(scaleX: 1.4, y: 1.4)
                }, completion: {_ in
                    //self.rightButton.animationZoom(scaleX: 1.0, y: 1.0)

                })
                
            })
            
        })
    }
    
    
    @objc func updateStepper(_ sender: UIStepper){
        quantity = Int(sender.value)
        lblAmount.text = String(quantity)
        updateTotalPrice()
        
    }
    
    @objc func cartButton(){
        let cartVC = CartVC()
 
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    func updateTotalPrice(){
        totalPrice = subTotalPrice! * Double(quantity)
        
        lblTotalPrice.text = String(Int(totalPrice)) 
    }
    @objc func btnSelected(){

        if var price = originalPrice {
            if btnSize1.isSelected{
                price = originalPrice!
                typeSize = "Small"
            }
            if btnSize2.isSelected{
                price += 5
                typeSize = "Medium"
            }
            if btnSize3.isSelected{
                price += 10
                typeSize = "Big"
            }
            
            self.subTotalPrice = price
        }
        updateTotalPrice()

    }
    

   
  
    func addControl(){
        
       view.sv(
        scrollView.sv(
            containerView.sv(
                imageBG.sv(
                    imageIcon
                ),
                lblName,
                lblPrice,
                lblAmount,
                btnQuanlity,
                lblTitleSize,
                stackViewSize,
                lblTitleSugar,
                stackViewSugar,
                lblTitleAdd,
                stackViewAdd,
                lblTotal,
                lblTotalPrice,
                lblVND,
                btnCart
          )
        )
    )
        scrollView.Top == view.safeAreaLayoutGuide.Top
        
        view.layout(
            0,
            |scrollView|,
            0
        )
        containerView.Width == view.Width
        scrollView.layout(
            0,
            |containerView|,
            0
        )
        
        containerView.layout(
            0,
            |imageBG.height(200)|,
            20,
            |-16-lblName-(>=20)-|,
            10,
            |-16-lblPrice-(>=50)-|,
            50,
            |-16-lblTitleSize.width(100)-10-stackViewSize-(>=16)-|,
            50,
            |-16-lblTitleSugar.width(100)-10-stackViewSugar-(>=16)-|,
            50,
            |-16-lblTitleAdd.width(100)-10-stackViewAdd-(>=16)-|,
            50,
            |-16-lblTotal-(>=20)-lblTotalPrice-10-lblVND-16-|,
            50,
            |-16-btnCart-16-| ~ 50,
            (>=20)
            
            
        )
        
        imageBG.layout(
            0,
            |imageIcon.centerHorizontally().centerVertically().size(100)|,
            0
            
        )
        
        btnQuanlity.Trailing == view.Trailing - 16
        btnQuanlity.Top == imageBG.Bottom + 30
        //btnQuanlity.Bottom == self.Bottom - 20
        
        lblAmount.Trailing == btnQuanlity.Leading - 10
        lblAmount.Top == btnQuanlity.Top
        //lblAmount.Bottom == btnQuanlity.Bottom

        imageBG.Width  == view.Width
        
        
    }
    
    func setupView(){
        
       lblVND.text = "VND"
        //top view
        lblName.text = "Capuchino"
        lblName.font = UIFont.boldSystemFont(ofSize: 24)
        lblPrice.text = "50 VND"
        lblPrice.font = UIFont.systemFont(ofSize: 20)
        
        lblAmount.font = UIFont.systemFont(ofSize: 24)
        lblAmount.text = String(quantity)
        
        
        //Size
        
        stackViewSize.addArrangedSubview(btnSize1)
        stackViewSize.addArrangedSubview(btnSize2)
        stackViewSize.addArrangedSubview(btnSize3)
        
        
        stackViewSize.spacing = 30
        
        lblTitleSize.text = "Size"
        lblTitleSize.font = UIFont.systemFont(ofSize: 20)
        btnSize1.setImage(UIImage(named: "Size1"), for: .normal)
        btnSize1.setImage(UIImage(named: "Size1-black"), for: .selected)
        btnSize2.setImage(UIImage(named: "Size2"), for: .normal)
        btnSize2.setImage(UIImage(named: "Size2-black"), for: .selected)
        btnSize3.setImage(UIImage(named: "Size3"), for: .normal)
        btnSize3.setImage(UIImage(named: "Size3-black"), for: .selected)
        
        btnSize1.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        btnSize2.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        btnSize3.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        
        //Sugar
        stackViewSugar.addArrangedSubview(btnSugar1)
        stackViewSugar.addArrangedSubview(btnSugar2)
        stackViewSugar.addArrangedSubview(btnSugar3)
        stackViewSugar.addArrangedSubview(btnSugar4)
        
        //stackView.distribution = .fillEqually
        
        stackViewSugar.spacing = 40
        
        lblTitleSugar.text = "Sugar"
        btnSugar1.setImage(UIImage(named: "Sugar1"), for: .normal)
        btnSugar1.setImage(UIImage(named: "Sugar1-black"), for: .selected)
        btnSugar2.setImage(UIImage(named: "Sugar2"), for: .normal)
        btnSugar2.setImage(UIImage(named: "Sugar2-black"), for: .selected)
        btnSugar3.setImage(UIImage(named: "Sugar3"), for: .normal)
        btnSugar3.setImage(UIImage(named: "Sugar3-black"), for: .selected)
        btnSugar4.setImage(UIImage(named: "Sugar4"), for: .normal)
        btnSugar4.setImage(UIImage(named: "Sugar4-black"), for: .selected)
        
        btnSugar1.addTarget(self, action: #selector(btnTapSugar(_:)), for: .touchUpInside)
        btnSugar2.addTarget(self, action: #selector(btnTapSugar(_:)), for: .touchUpInside)
        btnSugar3.addTarget(self, action: #selector(btnTapSugar(_:)), for: .touchUpInside)
        btnSugar4.addTarget(self, action: #selector(btnTapSugar(_:)), for: .touchUpInside)
        
        //Addtions
        stackViewAdd.addArrangedSubview(btnAdd1)
        stackViewAdd.addArrangedSubview(btnAdd2)
        //stackView.distribution = .fillEqually
        stackViewAdd.spacing = 30
        
        
        lblTitleAdd.text = "Additions"
        btnAdd1.setImage(UIImage(named: "Fill1"), for: .normal)
        btnAdd1.setImage(UIImage(named: "Fill1-black"), for: .selected)
        btnAdd2.setImage(UIImage(named: "Fill2"), for: .normal)
        btnAdd2.setImage(UIImage(named: "Fill2-black"), for: .selected)
        
        btnAdd1.addTarget(self, action: #selector(btnTapAddtions(_:)), for: .touchUpInside)
        btnAdd2.addTarget(self, action: #selector(btnTapAddtions(_:)), for: .touchUpInside)
        
        //add to cart
        lblTotal.text = "Total:"
        lblTotal.font = UIFont.systemFont(ofSize: 24)
        
        //lblTotalPrice.text = "0 VND"
        lblTotalPrice.font = UIFont.systemFont(ofSize: 20)
        
        btnCart.setTitle("Add to cart", for: .normal)
        btnCart.setTitleColor(.white, for: .normal)
        btnCart.backgroundColor = UIColor(red: 185/255, green: 128/255, blue: 104/255, alpha: 1.0)
        btnCart.layer.cornerRadius = 20
        
        //create init
        imageIcon.image = UIImage(named: imageName)
        lblName.text = textName
        lblPrice.text = money + " VND"
        lblTotalPrice.text = money
        subTotalPrice  = Double(money)
        originalPrice = Double(money)
        
        

    }
    @objc func btnTapped(_ sender: UIButton){
        
        //sender.isSelected = !sender.isSelected
        
       let btnArray = [btnSize1,btnSize2,btnSize3]
        let _ = btnArray.map({$0.isSelected =  false})
        sender.isSelected = true

    }
    @objc func btnTapSugar(_ sender: UIButton){
        let btnArraySugar = [btnSugar1,btnSugar2,btnSugar3,btnSugar4]
        let _ = btnArraySugar.map({$0.isSelected =  false})
    
        sender.isSelected = true
        
        if btnSugar1.isSelected  == true{
            typeSugar = "No sugar"
        }
        if btnSugar2.isSelected  == true{
            typeSugar = "Less sugar"
        }
        if btnSugar3.isSelected  == true{
            typeSugar = "Medium sugar"
        }
        if btnSugar4.isSelected  == true{
            typeSugar =  "Lots of sugar"
           
        }
    }
    @objc func btnTapAddtions(_ sender: UIButton){
        let btnArrayAddtion = [btnAdd1,btnAdd2]
        let _ = btnArrayAddtion.map({$0.isSelected =  false})
        sender.isSelected = true
        
        if btnAdd1.isSelected == true {
            typeAddtions = "Cream"
        }
        if btnAdd2.isSelected == true {
            typeAddtions = "Flower"
        }
    }
  
   
    
    func createInit(imageName:String , textName: String,money: String){
        self.imageName = imageName
        self.textName = textName
        self.money = money
        
    }
    
    
   

}
