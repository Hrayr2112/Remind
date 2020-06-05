//
//  ItemResult.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

struct ItemResult: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: ItemOrigin
    let location: ItemOrigin
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
