//
//  UserAction.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

import Alamofire

enum UserAction {
    case getItemsList
    case getItem(id: Int)
}

extension UserAction: APIAction {
    
    var method: HTTPMethod {
        switch self {
        case .getItemsList, .getItem:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getItemsList:
            return "/character"
        case let .getItem(id):
            return "/character/\(id)"
        }
    }
    
    var bodyParameters: [String : Any] {
        switch self {
        case .getItemsList, .getItem:
            return [:]
        }
    }
    
    var baseURL: String {
        return "https://rickandmortyapi.com/api"
    }
    
    var authHeader: [String : String] {
        return ["Content-Type": "application/json", "Accept" : "application/json"]
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}
