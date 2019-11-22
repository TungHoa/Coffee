//
//  Validation.swift
//  CafeTek
//
//  Created by Tung on 10/3/19.
//  Copyright © 2019 Tung. All rights reserved.
//

import Foundation


class Validation {
    func validateName(_ name:String) -> Bool {
        // Length be 18 characters max and 3 characters minimum, you can always modify.
        let nameRegex = "^\\w{3,18}$"
        
        
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName  = validateName.evaluate(with: name)
        
        return isValidateName
    }
    
    func validateEmailId(_ emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: emailID)
        return isValidateEmail
    }
    
    func validatePassword(_ password: String) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let validatePassword = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassword.evaluate(with: password)
        return isvalidatePass
    }
  
    
}
