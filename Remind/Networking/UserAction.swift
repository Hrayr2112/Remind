//
//  UserAction.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

import Alamofire

enum UserAction {
    case signUp(user: NewUser, confirmedPassword: String)
    case signIn(user: NewUser)
    case classrooms(name: String)
    case classroom(id: Int)
    case join(classroomId: Int)
    case uploadImage(image: Image, content: Data)
    case image(id: Int)
    case generate(background: Data, classroomId: Int)
    case explore
}

extension UserAction: APIAction {
    
    var method: HTTPMethod {
        switch self {
        case .classroom, .explore, .image:
            return .get
        case .signUp, .signIn, .classrooms, .join, .uploadImage, .generate:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/api/v1/signUp"
        case .signIn:
            return "/api/v1/signIn"
        case .classrooms:
            return "/api/v1/classrooms"
        case let .classroom(id):
            return "/api/v1/classrooms/\(id)}"
        case let .join(id):
            return "/api/v1/classrooms/\(id)/join"
        case let .uploadImage(image, _):
            return "/api/v1/users/\(image.id)/uploadImage"
        case let .image(id):
            return "/image/\(id)"
        case .generate:
            return "/api/v1/generate"
        case .explore:
            return "/api/v1/explore"
        }
    }
    
    var bodyParameters: [String : Any] {
        switch self {
        case let .signUp(user, confirmedPassword):
            return ["email": user.email ?? "",
                    "username": user.username ?? "",
                    "password": user.password,
                    "password_confirmation": confirmedPassword]
        case let .signIn(user):
            return ["email": user.email ?? "", "username": user.username ?? "", "password": user.password]
        case let .classrooms(name):
            return ["name": name]
        case let .uploadImage(image, content):
            return ["name": image.name, "content": content]
        case let .generate(background, classroomId):
            return ["background": background, "classroomId": classroomId]
        case .classroom, .join, .image, .explore:
            return [:]
        }
    }
    
    var baseURL: String {
        return "http://89.208.220.86"
    }
    
    var authHeader: [String : String] {
        switch self {
        case .signIn, .signUp:
            return ["Content-Type": "application/json", "Accept" : "application/json"]
        default:
            guard let token = UserManager.shared.token else {
                return [:]
            }
            let bearerToken = "Bearer" + " " + token
            return ["Content-Type": "application/json",
                    "Accept" : "application/json",
                    "Authorization" : bearerToken]
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}
