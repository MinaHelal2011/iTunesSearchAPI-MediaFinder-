//
//  ProfileVC.swift
//  TestUserDefault
//
//  Created by Mina Helal on 2/11/20.
//  Copyright © 2020 Mina Helal. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var genderLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var emialLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    
    private var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user =  UserDB.Shared.getUser(DefaultUser.Shared.idUserLogged)!
        presentProfileData()
    }
    
    @IBAction func LogOutButtomPressed(_ sender: Any) {
        DefaultUser.Shared.isLoggedIn = false
        goToSignInScreen()
    }
    
    @IBAction func BackButtomPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func goToSignInScreen() {
        let signInVC = UIStoryboard(name: SBs.authontication, bundle: nil).instantiateViewController(withIdentifier: VCs.signInVC)
        self.present(signInVC, animated: false, completion: nil)
    }
    
    private func presentProfileData() {
        let image : Data
        image = user.image as Data
        userImageView.image = UIImage(data: image)
        nameLabel.text = user.name
        emialLabel.text = user.email
        passwordLabel.text = user.Password
        genderLabel.text = (user.gender).map { $0.rawValue }
        addressLabel.text = user.address
        phoneLabel.text = user.phone
        ageLabel.text = String(user.age)
    }
}
