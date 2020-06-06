//
//  UserManager.swift
//  Remind
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

class UserManager {
    static let shared = UserManager()
    
    var token: String? {
        return UserDefaults.standard.value(forKey: "token") as? String
    }
    
    func save(user: User) {
        UserDefaults.standard.setValue(user.username, forKey: "username")
        UserDefaults.standard.setValue(user.email, forKey: "email")
        UserDefaults.standard.setValue(user.id, forKey: "id")
        UserDefaults.standard.setValue(user.images, forKey: "images")
        UserDefaults.standard.setValue(user.classromId, forKey: "classromId")
        UserDefaults.standard.setValue(user.password, forKey: "password")
    }
    
    func set(username: String) {
        UserDefaults.standard.setValue(username, forKey: "username")
    }
    
    func set(email: String) {
        UserDefaults.standard.setValue(email, forKey: "email")
    }
    
    func set(password: String) {
        UserDefaults.standard.setValue(password, forKey: "password")
    }
    
    func set(id: Int) {
        UserDefaults.standard.setValue(id, forKey: "id")
    }
    
    func set(token: String) {
        UserDefaults.standard.setValue(token, forKey: "token")
    }
    
    func current() -> User? {
        guard
            let username = UserDefaults.standard.value(forKey: "username") as? String,
            let email = UserDefaults.standard.value(forKey: "email") as? String,
            let id = UserDefaults.standard.value(forKey: "id") as? Int else {
                return nil
        }
        let images = UserDefaults.standard.value(forKey: "images") as? [Image]
        let classroomId = UserDefaults.standard.value(forKey: "classromId") as? Int
        let password = UserDefaults.standard.value(forKey: "password") as? String
        return User(id: id,
                    username: username,
                    email: email,
                    classromId: classroomId,
                    images: images,
                    password: password)
    }
    
    func removeUser() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "images")
        UserDefaults.standard.removeObject(forKey: "classromId")
    }
}
