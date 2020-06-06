//
//  NewUser.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

struct NewUser: Decodable {
    let email: String?
    let username: String?
    let password: String
}
