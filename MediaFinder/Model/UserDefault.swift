//
//  UserDefault.swift
//  TestUserDefault
//
//  Created by Mina Helal on 3/4/20.
//  Copyright © 2020 Mina Helal. All rights reserved.
//

import Foundation
import UIKit

//singortom
struct UserDefaultManger {
    
    private static let sharedInstance = UserDefaultManger()
    let UserDefaultStandard = UserDefaults.standard
    
    static func Shared() -> UserDefaultManger {
        return UserDefaultManger.sharedInstance
    }
    
    var isLoggedIn: Bool {
        set{
            UserDefaultStandard.set(newValue, forKey: UserDefaultKeys.isLogIn)
        } get {
            return UserDefaultStandard.bool(forKey: UserDefaultKeys.isLogIn)
        }
    }
    
    var idUserLogged : Int {
        set{
            UserDefaultStandard.set(newValue, forKey: UserDefaultKeys.idLogged)
        } get {
            return UserDefaultStandard.integer(forKey: UserDefaultKeys.idLogged)
        }
    }
    
    var idInsertMedia: Int {
        set{
            UserDefaultStandard.set(newValue, forKey: UserDefaultKeys.idInsertMedia)
        } get {
            return UserDefaultStandard.integer(forKey: UserDefaultKeys.idInsertMedia)
        }
    }
}

////Before Sigerton
//protocol DefualtUser {
//    var  forKey : String { get }
//    func SetObjectToUserDefault(user: User)
//    func FetchDataFromUserDefault() -> User
//    func RemoveObjectFromUserDefault()
////  func UpdateObjectFromUserDefault(user: User)
//}

//struct DefaultUserFunctions: DefualtUser  {
//
//
//    var forKey: String
//    let UserDefaultStandard = UserDefaults.standard
//
//
//    func SetObjectToUserDefault(user: User) {
//        if let encoded = try? JSONEncoder().encode(user) {
//           UserDefaultStandard.set(encoded, forKey: self.forKey)
//        }
//    }
//
//    func FetchDataFromUserDefault() -> User {
//        let decoder = UserDefaultStandard.data(forKey: self.forKey)
//        let userDecoded = try? JSONDecoder().decode( User.self, from: decoder!)
//        return(userDecoded!)
//    }
//
//    func RemoveObjectFromUserDefault() {
//        UserDefaultStandard.removeObject(forKey: self.forKey)
//    }
//
// /*
//    func UpdateObjectFromUserDefault(user: User) {
//        SetObjectToUserDefault(user: user)
//    }
//
//     func goToOtherViewContoller(nameOfStoryBoard: String, nameOfViewController: String, currentViewController: UIViewController, Bundle: Bundle, animated: Bool) {
//        let objectName = UIStoryboard(name: nameOfStoryBoard, bundle: Bundle).instantiateViewController(withIdentifier: nameOfViewController) //as! SignInVC
//        self.present(objectName, animated: animated, completion: nil)
//    }
//    */
//
//}


