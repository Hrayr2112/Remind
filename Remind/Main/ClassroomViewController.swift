//
//  ClassroomViewController.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

class ClassroomViewController: UIViewController {
    
    private enum ClassroomTab: Int {
        case people = 0
        case photos = 1
    }
    
    @IBOutlet weak private var mainScrollView: UIScrollView!
    @IBOutlet weak private var peopleTableView: UITableView!
    @IBOutlet weak private var photosCollectionView: UICollectionView!
    @IBOutlet weak private var peopleButton: UIButton!
    @IBOutlet weak private var photosButton: UIButton!
    private var selectedTab: ClassroomTab = .people
    private var isAnimating = false
    @IBOutlet weak private var tabLineLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if !isAnimating {
            let x = CGFloat(selectedTab.rawValue) * view.frame.size.width
            self.mainScrollView.contentOffset = CGPoint(x: x, y: 0)
        }
    }
    
    // MARK: - Tab Switching
    
    private func scrollToSelectedTab(animated: Bool) {
        let x = CGFloat(selectedTab.rawValue) * view.frame.size.width
        configureTopBarForSelectedTab(animated: animated)
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.mainScrollView.contentOffset = CGPoint(x: x, y: 0)
        }
    }
    
    private func configureTopBarForSelectedTab(animated: Bool) {
        isAnimating = true
        tabLineLeadingConstraint.constant = selectedTab == .people ? peopleButton.frame.origin.x : photosButton.frame.origin.x
        let selectedColor = UIColor.main
        let unselectedColor = UIColor.main.withAlphaComponent(0.5)
        UIView.animate(withDuration: animated ? 0.3 : 0, animations: {
            self.peopleButton.setTitleColor(self.selectedTab == .people ? selectedColor : unselectedColor,
                                               for: .normal)
            self.photosButton.setTitleColor(self.selectedTab == .photos ? selectedColor : unselectedColor,
                                            for: .normal)
            self.view.layoutIfNeeded()
        }) { (success) in
            self.isAnimating = false
        }
    }
    
    // MARK: - Actions
    
    @IBAction func peopleButtonTap() {
        selectedTab = .people
        scrollToSelectedTab(animated: true)
    }
    
    @IBAction func photosButtonTap() {
        selectedTab = .photos
        scrollToSelectedTab(animated: true)
    }

}
