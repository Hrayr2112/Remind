//
//  PhotoPreviewer.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit
import QuickLook

class PhotoPreviewer: NSObject {
    
    let images: [Image]
    
    // MARK: - Initialization
    
    init(images: [Image]) {
        self.images = images
    }
    
    // MARK: - Public
    
    func open(from viewController: UIViewController) {
        let previewVC = QLPreviewController()
        previewVC.dataSource = self
        
        viewController.present(previewVC, animated: true, completion: nil)
    }

}

extension PhotoPreviewer: QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return images.count
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return images[index]
    }
    
}

extension Image: QLPreviewItem {
    
    var previewItemURL: URL? {
        return URL(string: imageUrl)
    }
    
}
