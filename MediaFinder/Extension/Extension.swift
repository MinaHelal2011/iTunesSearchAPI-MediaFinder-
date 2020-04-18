//
//  Extension.swift
//  TestUserDefault
//
//  Created by Mina Helal on 3/22/20.
//  Copyright © 2020 Mina Helal. All rights reserved.
//

import Foundation
import UIKit
//extensions
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func validationAlert(_ Message: String) {
        let alertController = UIAlertController(title: "Error", message: Message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func validateName(_ name: String) -> Bool {
        let nameRegex = "^\\w{7,18}$"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@",emailRegex).evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,10}$"
        return NSPredicate(format: "SELF MATCHES %@",passwordRegex).evaluate(with: password)
    }
    
    func validatePhone(_ phone: String) -> Bool {
        let phoneRegex = "^\\d{3}\\d{3}\\d{5}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
    }
    
    func validateAge(_ age: String) -> Bool {
        let ageRegex = "[0-9]{2,2}"
        return NSPredicate(format: "SELF MATCHES %@", ageRegex).evaluate(with: age)
    }
    
}
extension UIView  {
    func roundCorners(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}

