//
//  UserManager.swift
//  Remind
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Remind. All rights reserved.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    var token: String? {
        return UserDefaults.standard.value(forKey: "token") as? String
    }
    
    var username: String? {
        return UserDefaults.standard.value(forKey: "username") as? String
    }
    
    var email: String? {
        return UserDefaults.standard.value(forKey: "email") as? String
    }
    
    var id: Int? {
        return UserDefaults.standard.value(forKey: "id") as? Int
    }
    
    var password: String? {
        return UserDefaults.standard.value(forKey: "password") as? String
    }
    
    var images: [Image]? {
        return UserDefaults.standard.value(forKey: "images") as? [Image]
    }
    
    var classroomId: Int? {
        return UserDefaults.standard.value(forKey: "classromId") as? Int
    }
    
    var imageId: Int? {
        return UserDefaults.standard.value(forKey: "image_id") as? Int
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
    
    func set(classroomId: Int) {
        UserDefaults.standard.setValue(classroomId, forKey: "classromId")
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
    
    func set(images: [Image]) {
        UserDefaults.standard.setValue(images, forKey: "images")
    }
    
    func set(imageId: Int) {
        UserDefaults.standard.setValue(imageId, forKey: "image_id")
    }
    
    func removeUser() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "images")
        UserDefaults.standard.removeObject(forKey: "classromId")
    }
    
}
