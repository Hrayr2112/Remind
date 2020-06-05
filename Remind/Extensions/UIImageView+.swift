//
//  UIImageView+.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(
        with imageURL: URL?,
        placeholder: UIImage? = nil,
        addOptions: KingfisherOptionsInfo? = nil
    ) {
        let options = configureOptions(with: bounds.size) + (addOptions ?? [])
        kf.setImage(with: imageURL,
                    placeholder: placeholder,
                    options: options)
    }
    
    func cancelDownload() {
        kf.cancelDownloadTask()
    }

    private func configureOptions(with size: CGSize) -> KingfisherOptionsInfo {
        return [
            .processor(DownsamplingImageProcessor(size: size)),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage,
        ]
    }
}
