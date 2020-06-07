//
//  PhotoPreviewer.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit
import QuickLook

class PhotoPreviewerItem: NSObject, QLPreviewItem {
    
    var previewItemURL: URL?
    
    init(previewItemURL: URL) {
        self.previewItemURL = previewItemURL
    }
    
}

class PhotoPreviewer: NSObject {
    
    enum LoadingType {
        case local
        case remote
    }
    
    let item: PhotoPreviewerItem?
    let preselectedIndex: Int
    
    // MARK: - Initialization
    
    init(image: Image, loadingType: LoadingType = .remote) {
        switch loadingType {
        case .local:
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileName = image.name
                let fileURL = documentsDirectory.appendingPathComponent(fileName.appending(".png"))
                self.item = PhotoPreviewerItem(previewItemURL: fileURL)
            } else {
                self.item = nil
            }
        case .remote:
            if let imageUrl = URL(string: image.imageUrl) {
                self.item = PhotoPreviewerItem(previewItemURL: imageUrl)
            } else {
                self.item = nil
            }
        }
        self.preselectedIndex = 0
    }
    
    // MARK: - Public
    
    func open(from viewController: UIViewController) {
        let previewVC = QLPreviewController()
        previewVC.dataSource = self
        previewVC.currentPreviewItemIndex = preselectedIndex
        
        viewController.present(previewVC, animated: true, completion: nil)
    }

}

extension PhotoPreviewer: QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return item ?? PhotoPreviewerItem(previewItemURL: URL(string: "")!)
    }
    
}

