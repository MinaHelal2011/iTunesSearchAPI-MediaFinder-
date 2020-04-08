//
//  DataBase-SQLite.swift
//  TestUserDefault
//
//  Created by Mina Helal on 3/21/20.
//  Copyright © 2020 Mina Helal. All rights reserved.
//

import Foundation
import SQLite

struct UserDataBase {
    
    private static let sharedInstance = UserDataBase()
    static func Shared() -> UserDataBase {
        return UserDataBase.sharedInstance
    }
    
    var dataBase: Connection!
    let usersTable = Table("users")
    //rows
    let id = Expression<Int>("id")
    let image = Expression<Data>("image")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    let password = Expression<String>("password")
    let gender = Expression<String>("gender")
    let age = Expression<Int>("age")
    let phone = Expression<String>("phone")
    let address = Expression<String>("address")
    
    func connectDataBase() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dataBase = try! Connection("\(path)/UserDataBase.sqlite3")
        UserDB.Shared.dataBase = dataBase
        print("file path is \(dataBase)")
    }
    
    func createTable() {
        let createTable = UserDB.Shared.usersTable.create(ifNotExists: true) { (table) in
            table.column(UserDB.Shared.id, primaryKey: .autoincrement)
            table.column(UserDB.Shared.image)
            table.column(UserDB.Shared.name)
            table.column(UserDB.Shared.email, unique: true, check: UserDB.Shared.email.like("%@%"))
            table.column(UserDB.Shared.password)
            table.column(UserDB.Shared.gender)
            table.column(UserDB.Shared.age)
            table.column(UserDB.Shared.phone)
            table.column(UserDB.Shared.address)
        }
        do {
            try UserDB.Shared.dataBase.run(createTable)
            print("Created Table")
            
        } catch {
            print(error)
        }
    }
    
    func insert(_ userStr: User) -> Bool {
        let insertUser = UserDB.Shared.usersTable.insert(UserDB.Shared.image <- userStr.image!, UserDB.Shared.name <- userStr.name!, UserDB.Shared.email <- userStr.email!, UserDB.Shared.password <- userStr.Password!, UserDB.Shared.gender <- userStr.gender!.rawValue ,UserDB.Shared.age <- userStr.age!, UserDB.Shared.phone <- userStr.phone!, UserDB.Shared.address <- userStr.address!)
        do {
            try UserDB.Shared.dataBase.run(insertUser)
            print("INSERTED USER")
            return true
            
        } catch {
            print(error)
            return false
        }
    }
    
    func checkSignIn(_ emailText: String, _ passwordText: String) -> [Int: Bool] {
        for user in try! UserDB.Shared.dataBase.prepare(UserDB.Shared.usersTable) {
            if (user[UserDB.Shared.email] == emailText && user[UserDB.Shared.password] == passwordText) {
                print("id: \(user[UserDB.Shared.id]), email: \(user[UserDB.Shared.email]), name: \(user[UserDB.Shared.name])")
                return [user[UserDB.Shared.id]: true]
            }
        }
        return [00: false]
    }
    
    func getUserImage(_ userId: Int) -> Data? {
        for user in try! UserDB.Shared.dataBase.prepare(UserDB.Shared.usersTable) {
            if (user[UserDB.Shared.id] == userId) {
                return user[UserDB.Shared.image]
            }
        }
        return nil
    }
    
    func getUser(_ userId: Int) -> User? {
        var userStr = User()
        for user in try! UserDB.Shared.dataBase.prepare(UserDB.Shared.usersTable) {
            if (user[UserDB.Shared.id] == userId) {
                userStr.image = user[UserDB.Shared.image]
                userStr.name = user[UserDB.Shared.name]
                userStr.email = user[UserDB.Shared.email]
                userStr.Password = user[UserDB.Shared.password]
                userStr.gender = Gender(rawValue: user[UserDB.Shared.gender])
                userStr.phone = user[UserDB.Shared.phone]
                userStr.age = Int(user[UserDB.Shared.age])
                userStr.address = user[UserDB.Shared.address]
                return userStr
            }
        }
        return nil
    }
    
}
