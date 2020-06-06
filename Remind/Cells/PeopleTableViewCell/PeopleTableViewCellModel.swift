//
//  PeopleTableViewCellModel.swift
//  Remind
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

struct PeopleTableViewCellModel {
    private let data: User
    
    init(data: User) {
        self.data = data
    }
    
    var id: Int {
        return data.id
    }
    
    var username: String {
        return data.username
    }
    
    var email: String {
        return data.email
    }
    
    var image: UIImage {
        if data.id == 0 {
            return UIImage(named: "ishxo") ?? UIImage()
        } else {
            return UIImage()
        }
    }
    
    var isPhotoAdded: Bool {
        if let imagesCount = data.imagesCount, imagesCount > 0 {
            return true
        }
        return false
    }
}
