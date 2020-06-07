//
//  MeViewController.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit
import Kingfisher

class MeViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameContainerView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        fillData()
    }
    
    private func configureViews() {
        title = "Profile"
        
        //avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
        avatarImageView.layer.masksToBounds = true
        
        usernameContainerView.layer.shadowColor = UIColor.black.cgColor
        usernameContainerView.layer.shadowOpacity = 0.2
        usernameContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        usernameContainerView.layer.shadowRadius = 5
        
        emailContainerView.layer.shadowColor = UIColor.black.cgColor
        emailContainerView.layer.shadowOpacity = 0.2
        emailContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        emailContainerView.layer.shadowRadius = 5
    }
    
    private func fillData() {
        usernameLabel.text = UserManager.shared.username
        emailLabel.text = UserManager.shared.email
        if let imageId  = UserManager.shared.imageId {
            let image = Image(id: imageId, name: "")
            avatarImageView.setImage(with: URL(string: image.imageUrl))
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func choosePhotoTapped() {
        let cameraViewController = CameraViewController()
        cameraViewController.captureBlock = { image in
            guard let username = UserManager.shared.username,
                let userId = UserManager.shared.id,
                let imageBase64 = image.pngData()?.base64EncodedString() else { return }
            RequestService().uploadImage(name: username.appending(UUID().uuidString).appending(".png"),
                                         content: imageBase64,
                                         userId: userId)
            { uploadImageResponse in
                switch uploadImageResponse {
                case .success(let response):
                    UserManager.shared.set(imageId: response.image.id)
                case .failure(let error):
                    let errorAc = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
                    errorAc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(errorAc, animated: true, completion: nil)
                }
            }
            self.avatarImageView.image = image
        }
        present(cameraViewController, animated: true, completion: nil)
    }

}
