//
//  SignInVC.swift
//  TestUserDefault
//
//  Created by Mina Helal on 2/11/20.
//  Copyright © 2020 Mina Helal. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var WelcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func SignInButtomPressed(_ sender: UIButton) {
        if isValid(){
            let result = UserDB.Shared.checkSignIn(emailTextField.text!, passwordTextField.text!)
            let userId = [Int](result.keys)
            let userChecked = [Bool](result.values)
            
            if userChecked[0] == true {
                DefaultUser.Shared.idUserLogged = userId[0]
                goToFavouriteMovieScreen()
            } else { validationAlert("Not Found! please Create account")}
        }
    }
    
    @IBAction func CreateNewAccountPresenter(_ sender: UIButton) {
        let signUpVC = UIStoryboard(name: SBs.authontication, bundle: nil).instantiateViewController(withIdentifier: VCs.signUpVC) as! SignUpVC
        self.present(signUpVC, animated: false, completion: nil)
    }
    
    private func goToFavouriteMovieScreen() {

        DefaultUser.Shared.isLoggedIn = true

        
        let favouriteMovieVC = UIStoryboard(name: SBs.main, bundle: nil).instantiateViewController(withIdentifier: VCs.favouriteMovieVC) as! FavouriteMovieVC
        self.present(favouriteMovieVC, animated: false, completion: nil)
    }
    
    private func isValid() -> Bool {
        guard let email = emailTextField.text, !email.isEmpty else{
            validationAlert("Enter Your Email")
            return false
        }
        guard validateEmail(email) else {
            validationAlert("Email is incorrect")
            return false
        }
        guard let password = passwordTextField.text, !password.isEmpty else{
            validationAlert("Enter Your Password")
            return false
        }
        guard validatePassword(password) else {
            validationAlert("Password is incorrect")
            return false
        }
        
        return true
    }
}
