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

class RegisterResource: Resource<RegisterResponse> {
    
    init(user: NewUser, confirmedPassword: String) {
        super.init(request: UserAction.signUp(user: user, confirmedPassword: confirmedPassword)) { response -> Result<RegisterResponse> in
            if let data = response as? Data {
                do {
                    let registerUser = try JSONDecoder().decode(RegisterResponse.self, from: data)
                    return Result.success(registerUser)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
    }
}

class LoginResource: Resource<LoginResponse> {
    
    init(user: NewUser) {
        super.init(request: UserAction.signIn(user: user)) { response -> Result<LoginResponse> in
            if let data = response as? Data {
                do {
                    let loginInfo = try JSONDecoder().decode(LoginResponse.self, from: data)
                    return Result.success(loginInfo)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
    }
}


class ClassroomsResource: Resource<Classroom> {
    
    init(name: String) {
        super.init(request: UserAction.classrooms(name: name)) { response -> Result<Classroom> in
            if let data = response as? Data {
                do {
                    let classroomInfo = try JSONDecoder().decode(Classroom.self, from: data)
                    return Result.success(classroomInfo)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
    }
    
    init(id: Int) {
        super.init(request: UserAction.obtainClassroom(id: id)) { response -> Result<Classroom> in
            if let data = response as? Data {
                do {
                    let classroomInfo = try JSONDecoder().decode(Classroom.self, from: data)
                    return Result.success(classroomInfo)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
    }
}

class JoinClassroomResource: Resource<Classroom> {
    
    init(id: Int) {
        super.init(request: UserAction.join(classroomId: id)) { response -> Result<Classroom> in
            if let data = response as? Data {
                do {
                    let joinClassroomInfo = try JSONDecoder().decode(Classroom.self, from: data)
                    return Result.success(joinClassroomInfo)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
    }
}

class UploadImageResource: Resource<UploadImageResponse> {
    
    init(name: String, content: String, userId: Int) {
        super.init(request: UserAction.uploadImage(name: name, content: content, userId: userId)) { response -> Result<UploadImageResponse> in
            if let data = response as? Data {
                do {
                    let uploadImageResource = try JSONDecoder().decode(UploadImageResponse.self, from: data)
                    return Result.success(uploadImageResource)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
    }
}

class ConvertedImageResource: Resource<Image> {
    
    init(id: Int) {
        super.init(request: UserAction.image(id: id)) { response -> Result<Image> in
            if let data = response as? Data {
                do {
                    let convertedImageInfo = try JSONDecoder().decode(Image.self, from: data)
                    return Result.success(convertedImageInfo)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
    }
}

class GenerateResource: Resource<Image> {
    
    init(background: String, classroomId: Int) {
        super.init(request: UserAction.generate(background: background, classroomId: classroomId)) { response -> Result<Image> in
            if let data = response as? Data {
                do {
                    let generatedInfo = try JSONDecoder().decode(Image.self, from: data)
                    return Result.success(generatedInfo)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
    }
}

class ExploreResource: Resource<ExploreResponse> {
    
    init() {
        super.init(request: UserAction.explore) { response -> Result<ExploreResponse> in
            if let data = response as? Data {
                do {
                    let exploreInfo = try JSONDecoder().decode(ExploreResponse.self, from: data)
                    return Result.success(exploreInfo)
                } catch {
                    return Result.failure(CustomError(value: error.localizedDescription))
                }
            }
            return Result.failure(CustomError(value: "No data"))
        }
    }
}
