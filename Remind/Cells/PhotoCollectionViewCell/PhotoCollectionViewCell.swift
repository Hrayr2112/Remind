//
//  PhotoCollectionViewCell.swift
//  Remind
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Remind. All rights reserved.
//

import Reusable
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell, NibReusable {
    
    // MARK: - UI
    
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Variables
    
    var viewModel: PhotoCollectionViewCellModel? {
        didSet {
            if let viewModel = viewModel {
                updateView(with: viewModel)
            }
        }
    }
    
    // MARK: - Configurations

    private func updateView(with viewModel: PhotoCollectionViewCellModel) {
        // This id indicates 'addImage' button should be shown
        if viewModel.data.id != 100000000 {
            imageView.setImage(with: URL(string: viewModel.imageUrl))
        }
    }
}
