//
//  RegisterResponse.swift
//  Remind
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Remind. All rights reserved.
//

struct RegisterResponse: Decodable {
    let token: String
    let user: User
}
