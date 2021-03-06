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
    
    func signUp(user: NewUser,
                confirmedPassword: String,
                _ completion: @escaping (Result<RegisterResponse>) -> Void) {
        api.request(RegisterResource(user: user, confirmedPassword: confirmedPassword), completion: completion)
    }
    
    func signIn(user: NewUser, _ completion: @escaping (Result<LoginResponse>) -> Void) {
        api.request(LoginResource(user: user), completion: completion)
    }
    
    func createClassroom(name: String, _ completion: @escaping (Result<Classroom>) -> Void) {
        api.request(ClassroomsResource(name: name), completion: completion)
    }
    
    func obtainClassroom(id: Int, _ completion: @escaping (Result<Classroom>) -> Void) {
        api.request(ClassroomsResource(id: id), completion: completion)
    }
    
    func joinClassroom(id: Int, _ completion: @escaping (Result<Classroom>) -> Void) {
        api.request(JoinClassroomResource(id: id), completion: completion)
    }
    
    func uploadImage(name: String, content: String, userId: Int, _ completion: @escaping (Result<UploadImageResponse>) -> Void) {
        api.request(UploadImageResource(name: name, content: content, userId: userId), completion: completion)
    }
    
    func getImage(id: Int, _ completion: @escaping (Result<Image>) -> Void) {
        api.request(ConvertedImageResource(id: id), completion: completion)
    }
    
    func generate(background: String,
                  classroomId: Int,
                  _ completion: @escaping (Result<Image>) -> Void) {
        api.request(GenerateResource(background: background, classroomId: classroomId), completion: completion)
    }
    
    func explore(_ completion: @escaping (Result<ExploreResponse>) -> Void) {
        api.request(ExploreResource(), completion: completion)
    }
}
