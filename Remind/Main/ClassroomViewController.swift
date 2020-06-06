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
        static let cellHeight: CGFloat = 57
        static let photoCellHeight: CGFloat = 135
    }
    
    private enum ClassroomTab: Int {
        case people = 0
        case photos = 1
    }
    
    // MARK: - UI
    
    @IBOutlet weak private var mainScrollView: UIScrollView!
    @IBOutlet weak private var peopleTableView: UITableView!
    @IBOutlet weak private var photosCollectionView: UICollectionView!
    @IBOutlet weak private var peopleButton: UIButton!
    @IBOutlet weak private var photosButton: UIButton!
    @IBOutlet weak private var tabLineLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var noClassroomView: UIView!
    
    // MARK: - Variables
    
    private var selectedTab: ClassroomTab = .people
    private var isAnimating = false
    private var peopleViewModels: [PeopleTableViewCellModel] = [] {
        didSet {
            peopleTableView.reloadData()
        }
    }
    private var photosViewModels: [PhotoCollectionViewCellModel] = [] {
        didSet {
            photosCollectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Classroom"
        configureTableView()
        configureCollectionView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    // MARK: - Private
    
    private func handleEmptyState() {
        if let classroomId = UserManager.shared.classroomId {
            // HRO do request here
            noClassroomView.isHidden = true
        } else {
            noClassroomView.isHidden = false
        }
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        peopleTableView.separatorStyle = .singleLine
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        
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
    
    private func configureCollectionView() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        if let layout = photosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
                
        photosCollectionView.register(cellType: PhotoCollectionViewCell.self)
        photosCollectionView.register(cellType: AddPhotoCollectionViewCell.self)
        
        // TODO: This info should be loaded from Backend
        photosViewModels = [PhotoCollectionViewCellModel(data: Image(id: 0, name: "10 класс")),
                            PhotoCollectionViewCellModel(data: Image(id: 1, name: "11 класс")),
                            PhotoCollectionViewCellModel(data: Image(id: 2, name: "10 класс")),
                            PhotoCollectionViewCellModel(data: Image(id: 3, name: "11 класс")),
                            PhotoCollectionViewCellModel(data: Image(id: 4, name: "10 класс")),]
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
    
    @IBAction func createClassroomButtonTap() {
        let ac = UIAlertController(title: "Create a classroom", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Enter the classroom name"
        }
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let answer = ac.textFields![0].text
            if let answer = answer, !answer.isEmpty {
                // HRO do request here
            } else {
                let errorAc = UIAlertController(title: "Please enter a classroom name", message: nil, preferredStyle: .alert)
                errorAc.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.createClassroomButtonTap()
                }))
                self.present(errorAc, animated: true, completion: nil)
            }
        }))
        present(ac, animated: true, completion: nil)
    }
    
    @IBAction func joinClassroomButtonTap() {
        let ac = UIAlertController(title: "Join a classroom", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Enter the classroom id"
        }
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let answer = ac.textFields![0].text
            if let answer = answer, !answer.isEmpty {
                // HRO do request here
            } else {
                let errorAc = UIAlertController(title: "Please enter a classroom id", message: nil, preferredStyle: .alert)
                errorAc.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.createClassroomButtonTap()
                }))
                self.present(errorAc, animated: true, completion: nil)
            }
        }))
        present(ac, animated: true, completion: nil)
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

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension ClassroomViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == photosViewModels.count - 1 {
            // Open Camera
        } else {
            let previewer = PhotoPreviewer(images: photosViewModels.map { $0.data }, preselectedIndex: indexPath.row )
            previewer.open(from: self)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == photosViewModels.count - 1 {
            let cell = collectionView.dequeueReusableCell(for: indexPath) as AddPhotoCollectionViewCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(for: indexPath) as PhotoCollectionViewCell
        cell.viewModel = photosViewModels[safe: indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ClassroomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 2, height: Locals.photoCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
