//
//  SignUpVC.swift
//  TestUserDefault
//
//  Created by Mina Helal on 2/11/20.
//  Copyright © 2020 Mina Helal. All rights reserved.
//

import UIKit
import SQLite


class SignUpVC: UIViewController {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var switcherGenderOutlet: UISwitch!
    @IBOutlet weak var addressLabel1: UITextField!
    
    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    // MARK: StatusBar Light
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Functional
    @IBAction func getAddressButtomPressed(_ sender: Any) {
        let mapVC = UIStoryboard(name: SBs.authontication, bundle: nil).instantiateViewController(withIdentifier: VCs.mapVC) as! MapVC
        mapVC.delegat = self
        self.present(mapVC, animated: false, completion: nil)
    }

    @IBAction func backButtom(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func SignUpButtomPressed(_ sender: UIButton) {
        if isValidData() {
            print(user.email!)
            if UserDB.Shared.insert(user) == true {
                goToSignInScreen()
            } else {
                validationAlert("Email is already in use")
            }
        }else {
            print("Fuck")
        }
    }
    
    @IBAction func SwitcherGenderChoose(_ sender: UISwitch) {
        if switcherGenderOutlet.isOn {
            user.gender = Gender.male
        }else {
            user.gender = Gender.female
        }
    }
    
    @IBAction func ChooseImagePressed(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                imagePickerController.allowsEditing = true
                self.present(imagePickerController, animated: true, completion: nil)
            }else {
                print("Camera is not found")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }

    // MARK: Private function
    private func goToSignInScreen() {
        let signInVC = UIStoryboard(name: SBs.authontication, bundle: nil).instantiateViewController(withIdentifier: VCs.signInVC) as! SignInVC
        self.present(signInVC, animated: false, completion: nil)
    }
}

// MARK: Regux
extension SignUpVC {
    
    private func isValidData() -> Bool{
        guard let name = nameTextField.text, !name.isEmpty, validateName(name) else{
            validationAlert("You Must Enter Your Name minmum 7 and maximum 18 like (MinaHelalAdly) ")
            return false
        }
        guard let email = emailTextField.text, !email.isEmpty, validateEmail(email) else{
            validationAlert("you must enter your email like (mina@yahoo.com)")
            return false
        }
        guard let password = passwordTextField.text, !password.isEmpty, validatePassword(password) else{
            validationAlert("you must enter your password have one upper case and one lower case and one special charchater amd miniman 6 character maxminum 10 ")
            return false
        }
        guard let phone = phoneTextField.text, !phone.isEmpty, validatePhone(phone) else{
            validationAlert("you must enter your phone have 11 number for egypt")
            return false
        }
        guard let age = ageTextField.text, !age.isEmpty, validateAge(age) else{
            validationAlert("you must enter your age have 2 number like 22 ")
            return false
        }
        guard let Location = addressLabel1.text, !Location.isEmpty else{
            validationAlert("you must Select your location")
            return false
        }
        
        user.image = userProfileImageView.image?.pngData()
        user.name = name
        user.email = email
        user.Password = password
        user.phone = phone
        user.age = Int(age)
        user.gender = switcherGenderOutlet.isOn ? Gender.male : Gender.female
        user.address = Location
        
        return true
    }
    
    enum RegexType: String {
        case name = "^\\w{7,18}$"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,10}$"
        case phone = "^\\d{3}\\d{3}\\d{5}$"
        case age = "[0-9]{2,2}"
    }
    
    func regex(_ text: String, _ regexType: RegexType) -> Bool {
        let regex = regexType.rawValue
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }
    
    func valideData(_ nameOfTextField: UITextField, _ regexType: RegexType, _ messageEmpty: String, _ messageNotValid: String) -> Bool {
        let textField = nameOfTextField.text
        if !textField!.isEmpty {
            if regex(textField! , regexType) == false {
                validationAlert(messageNotValid)
                return false
            }
        } else {
            validationAlert(messageEmpty)
            return false
        }
        return true
    }
    
}

// MARK: ImagePicker
extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.userProfileImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: Delegate
extension SignUpVC: Delegate {
    func takeLocation(_ address: String) {
        addressLabel1.text  = address
    }
}
