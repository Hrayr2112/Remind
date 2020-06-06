//
//  CameraViewController.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit
import CameraKit_iOS

class CameraViewController: UIViewController {
    
    let session = CKFPhotoSession()
    
    @IBOutlet weak var cameraContainerView: UIView!
    @IBOutlet weak var posesScrollView: UIScrollView!
    @IBOutlet weak var captureButtonContainerView: UIView!
    @IBOutlet weak var captureButton: UIButton!
    
    var captureBlock: ((UIImage) -> Void)?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - View Configuration
    
    private func configureViews() {
        configureCameraView()
        configureCaptureButton()
    }
    
    private func configureCameraView() {
        let previewView = CKFPreviewView(frame: self.view.bounds)
        
        previewView.session = session
        
        previewView.translatesAutoresizingMaskIntoConstraints = false
        cameraContainerView.insertSubview(previewView, belowSubview: posesScrollView)
        previewView.autopinEdgesToSuperviewEdges()
    }
    
    private func configureCaptureButton() {
        captureButtonContainerView.layer.masksToBounds = true
        captureButtonContainerView.layer.cornerRadius = captureButtonContainerView.bounds.width/2
        captureButton.layer.masksToBounds = true
        captureButton.layer.cornerRadius = captureButton.bounds.width/2
    }
    
    // MARK: - Actions
    
    @IBAction private func captureButtonPressed() {
        session.capture({ image, settings in
            self.captureBlock?(image)
            self.dismiss(animated: true, completion: nil)
        }, { error in
            
        })
    }

}
