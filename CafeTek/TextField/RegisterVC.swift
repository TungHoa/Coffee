//
//  RegisterVC.swift
//  CafeTek
//
//  Created by Tung on 9/25/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
import Stevia
import TextFieldEffects
import Firebase


class RegisterVC: UIViewController {

    let txtName: HoshiTextField = {
        let tl = HoshiTextField()
        tl.placeholder = "Enter your name"
        tl.placeholderColor = .gray
        
        tl.backgroundColor = .white
        tl.setBottomBorder(color: UIColor.darkGray.cgColor,height: 1.0)

        return tl
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
    
    let btnRegister: UIButton = {
        let br = UIButton()
        br.setTitle("Sign Up", for: .normal)
        br.backgroundColor = UIColor(red: 185/255, green: 128/255, blue: 104/255, alpha: 1.0)
        br.setTitleColor(.white, for: .normal)
        br.layer.cornerRadius = 20
        return br
    }()
    
    let lblEror: UILabel = {
       let le = UILabel()
        
        le.numberOfLines = 0
        le.textColor = .red
        le.textAlignment = .center
        
        return le
    }()
    let scrollView = TPKeyboardAvoidingScrollView()
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    let validation = Validation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .white
        
        title = "Sign Up"
        

        
        setupView()
        btnRegister.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        txtName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtName.tag = 100
        txtEmail.tag = 101
        txtPassword.tag = 102
        
    }
    
    @objc func handleSignUp(){
        
        let error = validateField()
        
        if error != nil {
            //showError(error!)
            AlertHelper.showAlert(message: error!, viewController: self)
        }
        else
        {
        guard let name = txtName.text else {return}
        guard let email = txtEmail.text else {return}
        guard let pass = txtPassword.text else {return}
        
       
        
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if error == nil && user != nil {
                print("User created")
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges(completion: { (error) in
                    if error == nil {
                        print("user display name changed")
                        
                        
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
                })
            }
            else{
                //print("Error:\(error?.localizedDescription)")
            }
        }
        }
    }
    func setupTabBar() -> UITabBarController
    {
        let tabBarVC = UITabBarController()
        
        
        
        
        let locateVC = LocateVC()
        locateVC.tabBarItem = UITabBarItem(title: "Locate", image: UIImage(named: "locate"), tag: 0)
        
        let cartVC = MenuVC()
        cartVC.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "cart"), tag: 1)
        
        let profileVC = ProfileVC()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 2)
        
        
        tabBarVC.setViewControllers([locateVC,cartVC,profileVC], animated: true)
        
        return tabBarVC
    }
    
    
    func setupView(){
        txtPassword.isSecureTextEntry = true
        
        view.sv(
            scrollView.sv(
                containerView.sv(
            
                    txtName,
                    txtEmail,
                    txtPassword,
                    btnRegister,
                    activityIndicator
                )
            )
        )
        
        scrollView.Top == view.safeAreaLayoutGuide.Top
        
        
        view.layout(
            0,
            |scrollView|,
            0
        )
        
        scrollView.layout(
            20,
            |containerView|,
            0
        )
        containerView.Width == view.Width
        
        containerView.layout(
            20,
            |-16-txtName-16-| ~ 50,
            30,
            |-16-txtEmail-16-| ~ 50,
            30,
            |-16-txtPassword-16-| ~ 50,
            50,
            |-50-btnRegister-50-| ~ 50,
            10,
            |activityIndicator.centerHorizontally()|,
            (>=20)
            
 
        )
        
    }
    
    func showError(_ message:String){
        lblEror.text = message
        lblEror.alpha = 1
    }
    func validateField() -> String?{
       
        
        if txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        let cleanPassword = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if validation.validatePassword(cleanPassword!) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        let cleanName = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if validation.validateName(cleanName!) == false {
            // Password isn't secure enough
            return "Name is invalid"
        }
        
        let cleanEmail = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if validation.validateEmailId(cleanEmail!) == false {
            // Password isn't secure enough
            return "Email is invalid"
        }
        
        
        return nil
    }

}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField{
            nextField.becomeFirstResponder()
        }
        else {
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
