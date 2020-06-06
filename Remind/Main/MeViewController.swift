//
//  MeViewController.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

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
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
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
        // load user info from userDefaults
        usernameLabel.text = "Ishxo"
        emailLabel.text = "pussyDestroyer69@gmail.com"
    }
    
    // MARK: - Actions
    
    @IBAction private func choosePhotoTapped() {
        let cameraViewController = CameraViewController()
        cameraViewController.captureBlock = { image in
            // upload image to backend
            self.avatarImageView.image = image
        }
        present(cameraViewController, animated: true, completion: nil)
    }

}
