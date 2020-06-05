//
//  ItemInfo.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

struct ItemInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String
    let prev: String
}
