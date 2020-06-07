//
//  ExploreViewController.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let cellHeight: CGFloat = 57
        static let photoCellHeight: CGFloat = 135
    }
    
    // MARK: - UI
    
    @IBOutlet private var mainCollectionView: UICollectionView!
    
    // MARK: - Variables
    
    private var photosViewModels: [PhotoCollectionViewCellModel] = [] {
        didSet {
            mainCollectionView.reloadData()
        }
    }
    
    private var fakeImages: [UIImage] = []
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Explore"
        configureMainCollectionView()
    }
    
    // MARK: - Configurations
    
    private func configureMainCollectionView() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        if let layout = mainCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
                
        mainCollectionView.register(cellType: PhotoCollectionViewCell.self)
        
        // TODO: This info should be loaded from Backend
        photosViewModels = [PhotoCollectionViewCellModel(data: Image(id: 0, name: "10 класс а")),
                            PhotoCollectionViewCellModel(data: Image(id: 1, name: "11 класс а")),
                            PhotoCollectionViewCellModel(data: Image(id: 2, name: "10 класс б")),
                            PhotoCollectionViewCellModel(data: Image(id: 3, name: "11 класс б")),
                            PhotoCollectionViewCellModel(data: Image(id: 0, name: "10 класс в")),
                            PhotoCollectionViewCellModel(data: Image(id: 1, name: "11 класс в")),
                            PhotoCollectionViewCellModel(data: Image(id: 2, name: "10 класс г")),
                            PhotoCollectionViewCellModel(data: Image(id: 3, name: "11 класс г"))]
        
        fakeImages = [UIImage(named: "family_one") ?? UIImage(),
                      UIImage(named: "family_two") ?? UIImage(),
                      UIImage(named: "family_three") ?? UIImage(),
                      UIImage(named: "family_four") ?? UIImage(),
                      UIImage(named: "family_five") ?? UIImage(),
                      UIImage(named: "family_six") ?? UIImage(),
                      UIImage(named: "family_seven") ?? UIImage(),
                      UIImage(named: "family_eight") ?? UIImage()]
        
        for i in 0..<photosViewModels.count {
            ImageManager.saveImage(imageName: photosViewModels[i].name, image: fakeImages[i])
        }
    }

}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension ExploreViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previewer = PhotoPreviewer(image: photosViewModels[indexPath.row].data, loadingType: .local)
        previewer.open(from: self)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fakeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as PhotoCollectionViewCell
        cell.viewModel = photosViewModels[safe: indexPath.row]
        cell.imageView.image = fakeImages[safe: indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
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
