//
//  Item.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

struct Item {
    
    let id: Int?
    let firstName: String
    let lastName: String
    let email: String
    let avatarUrl: String?
    
    init(id: Int? = nil, firstName: String, lastName: String, email: String, avatarUrl: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.avatarUrl = avatarUrl
    }
    
}
