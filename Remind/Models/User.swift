//
//  User.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

struct User: Decodable {
    let id: Int
    let username: String
    let email: String
    let classromId: Int?
    let images: [Image]?
    let password: String?
    
    init(id: Int, username: String, email: String, classromId: Int?, images: [Image]?, password: String? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.classromId = classromId
        self.images = images
        self.password = password
    }
}
