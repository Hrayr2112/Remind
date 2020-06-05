//
//  Array+.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        return (0 ..< count).contains(index) ? self[index] : nil
    }
}
