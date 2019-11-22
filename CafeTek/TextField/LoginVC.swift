//
//  LoginVC.swift
//  CafeTek
//
//  Created by Tung on 9/25/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
import Stevia
import TextFieldEffects
import Firebase
class LoginVC: UIViewController {

    
    let lblTitle: UILabel = {
       let lt = UILabel()
       lt.text = "Welcome Back !"
        lt.font = UIFont.systemFont(ofSize: 36)
        lt.textColor = UIColor(red: 185/255, green: 128/255, blue: 104/255, alpha: 1.0)
        lt.textAlignment = .center
        return lt
    }()
    let txtEmail: HoshiTextField = {
        let tl = HoshiTextField()
        tl.placeholder = "Enter your email"
        tl.placeholderColor = .gray
        tl.backgroundColor = .white
        tl.setBottomBorder(color: UIColor.darkGray.cgColor,height: 1.0)
    
        return tl
    }()
    
    let txtPassword: HoshiTextField = {
        let tl = HoshiTextField()
        tl.placeholder = "Enter your password"
        tl.placeholderColor = .gray
        tl.backgroundColor = .white
        tl.setBottomBorder(color: UIColor.darkGray.cgColor,height: 1.0)

        return tl
    }()
    
     let lblForgot: UILabel = {
        let lf = UILabel()
        lf.text = "Forgot password?"
        lf.textColor = UIColor(red: 185/255, green: 128/255, blue: 104/255, alpha: 1.0)
        lf.font = UIFont.systemFont(ofSize: 12)
        return lf
    }()
   
    let btnLogin: UIButton = {
        let bl = UIButton()
        bl.setTitle("Login", for: .normal)
        bl.setTitleColor(UIColor(red: 185/255, green: 128/255, blue: 104/255, alpha: 1.0), for: .normal)
        bl.layer.borderWidth = 1
        bl.layer.borderColor = UIColor(red: 185/255, green: 128/255, blue: 104/255, alpha: 1.0).cgColor
        bl.layer.cornerRadius = 20
        
        return bl
    }()
    let lblAccount: UILabel = {
       let la = UILabel()
        la.text = "Dont have an account? Regsiter"
        
        la.textAlignment = .center
        la.textColor = UIColor(red: 185/255, green: 128/255, blue: 104/255, alpha: 1.0)
        la.font = UIFont.systemFont(ofSize: 12)
        return la
    }()
   
    
    let scrollView = TPKeyboardAvoidingScrollView()
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    let validation = Validation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Login"
        
       view.backgroundColor = .white
        
        
        setupView()
        btnLogin.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtEmail.tag = 100
        txtPassword.tag = 101
     
    }
    @objc func handleSignIn(){
        guard let email = txtEmail.text else { return}
        guard let pass = txtPassword.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if error == nil && user != nil {
                
                UIView.animate(withDuration: 1, animations: {
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.style = .gray
                }, completion: { (_) in
                    self.activityIndicator.stopAnimating()
                })
                
                
                DispatchQueue.main.async {
                     self.navigationController?.pushViewController(self.setupTabBar(), animated: true)
                    
                    
                }

            }
            else{

                AlertHelper.showAlert(message: error!.localizedDescription, viewController: self)
                
            }
        }
    }
    func setupTabBar() -> UITabBarController
    {
        let tabBarVC = UITabBarController()

        let locateVC = LocateVC()
        locateVC.tabBarItem = UITabBarItem(title: "Locate", image: UIImage(named: "locate"), tag: 0)
        
        let menuVC = MenuVC()
        menuVC.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "cart"), tag: 1)
        
        let profileVC = ProfileVC()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 2)
        
        
        tabBarVC.setViewControllers([locateVC,menuVC,profileVC], animated: true)
        
        return tabBarVC
    }
    
    func setupView(){
//        view.sv(
//
//                    lblTitle,txtEmail,txtPassword,lblForgot,btnLogin,lblError
//                )
        txtPassword.isSecureTextEntry = true
        view.sv(
            scrollView.sv(
                containerView.sv(
                
                    lblTitle,
                    txtEmail,
                    txtPassword,
                    lblForgot,
                    btnLogin,
                    lblAccount,
                    activityIndicator
                    )
                )
            
            
        )
        
        //lblTitle.Top == view.safeAreaLayoutGuide.Top + 30
        
       
        scrollView.Top == view.safeAreaLayoutGuide.Top
        view.layout(
            0,
            |-0-scrollView-0-|,
            0
        )
        scrollView.layout(
            0,
            |containerView|,
            0
    
        )
        containerView.Width == view.Width
   
       containerView.layout(
            20,
            |lblTitle.centerHorizontally()|,
            30,
            |-16-txtEmail-16-| ~ 50,
            30,
            |-16-txtPassword-16-| ~ 50,
            10,
            |-(>=50)-lblForgot-16-|,
            50,
            |-50-btnLogin-50-| ~ 50,
            20,
            |lblAccount.centerHorizontally()|,
            10,
            |activityIndicator.centerHorizontally()|,
            (>=20)
            

        )

    }


}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField{
            nextField.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setBottomBorder(color: UIColor(red: 185/255, green: 128/255, blue: 104/255, alpha: 1.0).cgColor,height: 2.0)
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.setBottomBorder(color: UIColor.darkGray.cgColor,height: 1.0)
    }
}
