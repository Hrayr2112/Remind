//
//  APIClient.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

import Alamofire

protocol APIClientProtocol {
    func request<T>(_ resource: Resource<T>, completion: @escaping (Result<T>) -> Void)
}

struct APIClient: APIClientProtocol {
    func request<T>(_ resource: Resource<T>, completion: @escaping (Result<T>) -> Void) {
        Alamofire
            .request(resource.request)
            .responseData { dataResponse in
                completion(dataResponse.result.flatMap2(resource.parse))
        }
    }
}
