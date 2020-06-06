//
//  Classroom.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

struct Classroom: Decodable {
    let id: Int
    let name: String
    let participants: [User]
    let images: [Image]
}
