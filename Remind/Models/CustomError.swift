//
//  CustomError.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

import Foundation

struct CustomError: LocalizedError {
    let value: String
    var localizedDescription: String {
        return value
    }
}
