//
//  ClassroomViewController.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

class ClassroomViewController: UIViewController {
    
    private enum Locals {
        static let tableBackgroundColor = UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
        static let cellHeight: CGFloat = 57
    }
    
    private enum ClassroomTab: Int {
        case people = 0
        case photos = 1
    }
    
    @IBOutlet weak private var mainScrollView: UIScrollView!
    @IBOutlet weak private var peopleTableView: UITableView!
    @IBOutlet weak private var photosCollectionView: UICollectionView!
    @IBOutlet weak private var peopleButton: UIButton!
    @IBOutlet weak private var photosButton: UIButton!
    @IBOutlet weak private var tabLineLeadingConstraint: NSLayoutConstraint!
    
    private var selectedTab: ClassroomTab = .people
    private var isAnimating = false
    private var peopleViewModels: [PeopleTableViewCellModel] = [] {
        didSet {
            peopleTableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
        UIView.animate(withDuration: animated ? 0.3 : 0, animations: {
            self.view.layoutIfNeeded()
        }) { (success) in
            self.isAnimating = false
        }
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        peopleTableView.backgroundColor = Locals.tableBackgroundColor
        
        peopleTableView.register(cellType: PeopleTableViewCell.self)
        
        // TODO: This info should be loaded from Backend
        peopleViewModels = [
            PeopleTableViewCellModel(data: User(id: 1,
                                                username: "Александр Петров",
                                                email: "alex.petrov@mail.ru",
                                                classromId: nil,
                                                images: nil)),
            PeopleTableViewCellModel(data: User(id: 0,
                                                username: "Ишхан Асланян",
                                                email: "ishxan.aslanyan@mail.ru",
                                                classromId: nil,
                                                images: nil)),
            PeopleTableViewCellModel(data: User(id: 2,
                                                username: "Дарья Дацалова",
                                                email: "dasha.1987.dac@mail.ru",
                                                classromId: nil,
                                                images: nil)),
            PeopleTableViewCellModel(data: User(id: 3,
                                                username: "Артемий Кузнецов",
                                                email: "art.kuz@mail.ru",
                                                classromId: nil,
                                                images: nil)),
            PeopleTableViewCellModel(data: User(id: 4,
                                                username: "Антон Логвинов",
                                                email: "logvinov.anton.1992@mail.ru",
                                                classromId: nil,
                                                images: nil))]
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

extension ClassroomViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.mainScrollView {
            let width = scrollView.frame.size.width;
            let page = Int((scrollView.contentOffset.x + (0.5 * width)) / width);
            selectedTab = ClassroomTab(rawValue: page < 0 ? 0 : page > 1 ? 1 : page)!
            configureTopBarForSelectedTab(animated: true)
        }
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension ClassroomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as PeopleTableViewCell
        cell.viewModel = peopleViewModels[safe: indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleViewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Locals.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
