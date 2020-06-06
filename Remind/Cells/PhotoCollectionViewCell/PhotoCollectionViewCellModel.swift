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
    
    var image: UIImage {
        
        // TODO: - Remove this shit
        return UIImage(named: "family") ?? UIImage()
    }
    
    var name: String {
        return data.name
    }
}
