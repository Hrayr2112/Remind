//
//  PhotoCollectionViewCellModel.swift
//  Remind
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

struct PhotoCollectionViewCellModel {
    
    let data: Image
    
    init(data: Image) {
        self.data = data
    }
    
    var imageUrl: String {
        return data.imageUrl
    }
    
    var name: String {
        return data.name
    }
}
