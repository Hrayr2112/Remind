//
//  ItemsList.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

struct ItemsList: Decodable {
    let info: ItemInfo
    let results: [ItemResult]
    
    enum CodingKeys: String, CodingKey {
      case info, results
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try values.decode(ItemInfo.self, forKey: .info)
        results = try values.decode([ItemResult].self, forKey: .results)
    }
}
