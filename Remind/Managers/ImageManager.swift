//
//  ImageManager.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/7/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

class ImageManager {
    
    static func saveImage(imageName: String, image: UIImage) {
     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName.appending(".png"))
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        // Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
    }

}
