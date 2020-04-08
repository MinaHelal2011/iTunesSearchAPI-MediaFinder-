//
//  Constants.swift
//  MediaFinder
//
//  Created by Mina Helal on 3/31/20.
//  Copyright © 2020 Mina Hilal. All rights reserved.
//

import Foundation

struct DefaultUser {
    static var Shared = UserDefaultManger.Shared()
}

struct UserDB {
    static var Shared = UserDataBase.Shared()
}

struct MediaDB {
    static var Shared = MediaDataBase.Shared()
}

struct UserDefaultKeys {
    static let isLogIn = "isLoggedIn"
    static let idLogged = "idUserLogged"
    static let idInsertMedia = "idInsertMedia"
}
struct Urls {
    static let base = "https://itunes.apple.com/search"
}

struct paramters {
    static let term =  "term"
    static let media = "media"
}

struct SBs {
    static let authontication = "Authontication"
    static let main = "Main"
}

struct VCs {
    static let signInVC = "SignInVC"
    static let signUpVC = "SignUpVC"
    static let mapVC = "MapVC"
    static let favouriteMovieVC = "FavouriteMovieVC"
    static let mediaCellNip = "MediaCellNip"
    static let profileVC = "ProfileVC"
}
