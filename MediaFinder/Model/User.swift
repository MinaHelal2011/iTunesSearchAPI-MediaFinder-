//
//  User.swift
//  TestUserDefault
//
//  Created by Mina Helal on 2/12/20.
//  Copyright © 2020 Mina Helal. All rights reserved.
//

import Foundation
import UIKit

enum Gender: String, Codable {
    case male,female
}

struct User: Codable{
    var image: Data!
    var name: String!
    var email: String!
    var Password: String!
    var gender: Gender!
    var phone: String!
    var age: Int!
    var address: String!
}

