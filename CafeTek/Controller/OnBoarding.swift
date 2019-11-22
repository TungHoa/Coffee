//
//  OnBoarding.swift
//  CafeTek
//
//  Created by Tung on 9/25/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit
import Stevia
import Firebase
import FacebookCore
import FacebookLogin
class OnBoarding: UIViewController {

    let artWork: UIImageView = {
      let aw = UIImageView()
        aw.image = UIImage(named: "artwork")
        aw.contentMode = .scaleToFill
        return aw
    }()
    let viewContent = UIView()
    
    let lblTitle: UILabel = {
       let lt = UILabel()
        lt.text = "Get the best coffee! "
        lt.font = UIFont.systemFont(ofSize: 36)
        lt.textColor = UIColor(red: 185/255, green: 128/255, blue: 104/255, alpha: 1.0)
        lt.textAlignment = .center
        
        return lt
    }()
    
    let btnRegister: UIButton = {
        let br = UIButton()
        br.setTitle("Sign Up", for: .normal)
        br.backgroundColor = UIColor(red: 185/255, green: 128/255, blue: 104/255, alpha: 1.0)
        br.setTitleColor(.white, for: .normal)
        br.layer.cornerRadius = 20
        return br
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
    
    
    let btnFacebook: UIButton = {
        let bf = UIButton()
        bf.setTitle("Connect with Facebook", for: .normal)
        bf.setTitleColor(UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0), for: .normal)
        bf.layer.borderWidth = 1
        bf.layer.borderColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0).cgColor
        bf.backgroundColor = .white
        
        bf.setImage(UIImage(named: "facebook"), for: .normal)
        bf.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -8)
        
        bf.layer.cornerRadius = 20
        
        return bf
    }()
    
    var strEmail: String!
    var strID: String!
    var strName: String!
    
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
            btnLogin.addTarget(self, action: #selector(switchLogin), for: .touchUpInside)
            
            btnRegister.addTarget(self, action: #selector(switchRegister), for: .touchUpInside)
            
            btnFacebook.addTarget(self, action: #selector(onLoginFB), for: .touchUpInside)
           
            
            setupView()
            
            
    }
    @objc func switchLogin(){
        let loginVC = LoginVC()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationController?.pushViewController(loginVC, animated: true)
    }
    @objc func switchRegister(){
        let registerVC = RegisterVC()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationController?.pushViewController(registerVC, animated: true)
    }
    @objc func onLoginFB(){
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .cancelled:
                print("Users cancelled")
                break
            case .failed(let err):
                print(err)
                break
            case .success(let grantedPermissions, _, _):
//          case .success(let grantedPermissions, let declinePermissions,let accessToken):
                
                if(grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    // fbLoginManager.logOut()
                    
                    self.navigationController?.pushViewController(self.setupTabBar(), animated: true)
                }
            }
        }
    }
    
    func getFBUserData () {
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(normal), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    print((result! as AnyObject))
                    //  print(((result! as AnyObject).value(forKey: "id") as? String)!)
                    
                    self.strEmail = ((result! as AnyObject).value(forKey: "email") as? String) ?? ""
                    self.strID = ((result! as AnyObject).value(forKey: "id") as? String) ?? ""
                    self.strName = ((result! as AnyObject).value(forKey: "name") as? String) ?? ""
                    
                    print(self.strID!)
                    print(self.strName!)
                    print(self.strEmail!)
                    //                    self.TextFBEmail.text = self.strEmail
                    
                }
            })
        }
    }
    func setupTabBar() -> UITabBarController
    {
        let tabBarVC = UITabBarController()
        
        
        
        
        let locateVC = LocateVC()
        locateVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "locate"), tag: 0)
        
        let cartVC = MenuVC()
        cartVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "cart"), tag: 1)
        
        let profileVC = ProfileVC()
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile"), tag: 2)
        
        
        tabBarVC.setViewControllers([locateVC,cartVC,profileVC], animated: true)
        
        return tabBarVC
    }
    
    

    
    func setupView(){
        view.sv(artWork,
                viewContent.sv(
                    lblTitle,
                    btnLogin,
                    btnRegister,
                    btnFacebook
            )
                )
        
        artWork.Top == view.safeAreaLayoutGuide.Top
        //viewContent.Bottom == view.safeAreaLayoutGuide.Bottom
        view.layout(
            0,
            |-0-artWork.height(40%)-0-|,
            50,
            |viewContent.height(40%)|
        )
        
        let btnWidth = (view.frame.size.width - 48) / 2
        viewContent.layout(
            10,
            |lblTitle.centerHorizontally()|,
            50,
            |-16-btnRegister.width(btnWidth)-16-btnLogin.width(btnWidth)-16-| ~ 50,
            20,
            |-16-btnFacebook-16-| ~ 50,
            (>=20)
        )
    }
   
  
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    

   

}
