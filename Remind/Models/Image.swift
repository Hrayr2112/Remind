//
//  Image.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

import Foundation

class Image: NSObject, Decodable {
    
    let id: Int
    let name: String
    
    var imageUrl: String {
        return UserAction.baseURL.appending(UserAction.image(id: id).path)
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}
