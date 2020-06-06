//
//  PeopleTableViewCell.swift
//  Remind
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Remind. All rights reserved.
//

import Reusable
import UIKit

class PeopleTableViewCell: UITableViewCell, NibReusable {
    
    // MARK: - UI
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var photoAddedView: UIView!
    
   
    // MARK: - Variables
    
    var viewModel: PeopleTableViewCellModel? {
        didSet {
            if let viewModel = viewModel {
                updateView(with: viewModel)
            }
        }
    }
    
    // MARK: - Configurations
    
    private func updateView(with viewModel: PeopleTableViewCellModel) {
        usernameLabel.text = viewModel.username
        emailLabel.text = viewModel.email
        avatarImageView.image = viewModel.image
        
        if viewModel.id == 0 {
            photoAddedView.isHidden = false
        } else {
            photoAddedView.isHidden = true
        }
        selectionStyle = .none
    }
}
