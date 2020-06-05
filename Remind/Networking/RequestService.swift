//
//  RequestService.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit

import Alamofire

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

struct RequestService {
    
    private let api: APIClientProtocol = APIClient()
    
    func getItemsList(_ completion: @escaping (Result<ItemsList>) -> Void) {
        api.request(ItemsResource(), completion: completion)
    }
}
