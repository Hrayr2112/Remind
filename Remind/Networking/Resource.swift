//
//  Resource.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

open class Resource<T> {
    let request: APIAction
    let parse: (Any) -> Result<T>
    
    init(request: APIAction, parse: @escaping (Any) -> Result<T>) {
        self.request = request
        self.parse = parse
    }
}

class ItemsResource: Resource<ItemsList> {
    
    init() {
        super.init(request: UserAction.getItemsList) { response -> Result<ItemsList> in
            if let data = response as? Data {
                do {
                    let decodedUsers = try JSONDecoder().decode(ItemsList.self, from: data)
                    return Result.success(decodedUsers)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
        
    }
}
