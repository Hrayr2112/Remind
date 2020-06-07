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
    case obtainClassroom(id: Int)
    case join(classroomId: Int)
    case uploadImage(name: String, content: String, userId: Int)
    case image(id: Int)
    case generate(background: String, classroomId: Int)
    case explore
}

extension UserAction: APIAction {
    
    var method: HTTPMethod {
        switch self {
        case .obtainClassroom, .explore, .image:
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
        case let .obtainClassroom(id):
            return "/api/v1/classrooms/\(id)"
        case let .join(id):
            return "/api/v1/classrooms/\(id)/join"
        case let .uploadImage(_, _, userId):
            return "/api/v1/users/\(userId)/images"
        case let .image(id):
            return "/images/\(id)"
        case let .generate(_, id):
            return "/api/v1/generate/\(id)"
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
            
            if let email = user.email, email != "" {
                return ["email": email, "password": user.password]
            } else {
                return ["username": user.username ?? "", "password": user.password]
            }
        case let .classrooms(name):
            return ["name": name]
        case let .uploadImage(name, content, _):
            return ["name": name, "content": content]
        case let .generate(background, _):
            return ["background": background]
        case .obtainClassroom, .join, .image, .explore:
            return [:]
        }
    }
    
    static var baseURL: String {
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
    
    var timeoutIntervalForRequest: TimeInterval? {
        switch self {
        case .generate(_, _):
            return 35
        default:
            return nil
        }
    }
    
}
