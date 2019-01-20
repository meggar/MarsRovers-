//
//  FavoriteImages_ViewController.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/20/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "FavoritesCollectionViewCell"


class FavoriteImages_ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var moc: NSManagedObjectContext?
    
    var roverPhoto_datasource: RoverPhoto_DataSource?
    var photos:[FavoriteRoverImage] = []
    
    
    // Core data helpers
    private func getFavoriteImagesFromCoreData(moc: NSManagedObjectContext) {

        let fetchRequest: NSFetchRequest = FavoriteRoverImage.fetchRequest()
        
        if let objects = try? moc.fetch(fetchRequest) {
            photos = objects.compactMap{ $0 }
        }
    }
    
    // MARK: - UView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(FavoriteImages_CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if let moc = moc {
            getFavoriteImagesFromCoreData(moc: moc)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let moc = moc {
            getFavoriteImagesFromCoreData(moc: moc)
            collectionView.reloadData()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }

    // MARK: - Initializers
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(collectionViewLayout: layout)
    }
    
    convenience init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        
        self.init(collectionViewLayout: layout)
        
        title = "Favorite Images"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented for FavoriteImages_ViewController")
    }
}


// MARK: - UICollectionViewDataSource

extension FavoriteImages_ViewController {
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoriteImages_CollectionViewCell
        
        if let imgSrc = photos[indexPath.row].urlString,
            let imageUrl = URL(string: imgSrc) {
            
            roverPhoto_datasource?.getImageData(url: imageUrl) { data in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.photoView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        if let cameraName = photos[indexPath.row].camera,
            let earthDate = photos[indexPath.row].earthDate {
            
            cell.photoNameLabel.text = "\(earthDate) - \(cameraName)"
        }
        
        return cell
    }
}


// MARK: - UICollectionViewDelegate

extension FavoriteImages_ViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let selectedCell = collectionView.cellForItem(at: indexPath) as? FavoriteImages_CollectionViewCell {
            let detailViewController = RoverPhotoDetail_ViewController()
            detailViewController.photo = photos[indexPath.row]
            detailViewController.moc = moc
            detailViewController.image = selectedCell.photoView.image
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}




// MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteImages_ViewController {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 100, height: 100)
        }
        
        let columns = 3
        let spacing = Int(layout.minimumInteritemSpacing) * (columns - 1)
        let side = (Int(collectionView.bounds.width)-spacing) / columns
        
        return CGSize(width: side, height: side)
    }
}




// MARK: - Custom CollectionView Cell for FavoriteImages_ViewController

class FavoriteImages_CollectionViewCell: UICollectionViewCell {
    
    let photoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let photoNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.backgroundColor = .black
        view.textColor = .appWhite
        view.font = .appFontSmall
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoView)
        contentView.addSubview(photoNameLabel)
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            photoNameLabel.heightAnchor.constraint(equalToConstant: 20),
            photoNameLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            photoNameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            photoNameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            
            photoView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: photoNameLabel.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor)
            
            ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented for FavoriteImages_CollectionViewCell")
    }
}
