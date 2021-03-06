//
//  RoverPhotos_CollectionViewController.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "RoverCollectionViewCell"



class RoverPhotos_CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var moc: NSManagedObjectContext?
    
    var photos: Photos?
    var roverType: RoverType = .curiosity
    var solDate = 1
    var roverPhoto_datasource: RoverPhoto_DataSource?
    

    // MARK: UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(RoverPhoto_CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        roverPhoto_datasource?.getPhotosFor(rover: roverType, onSolDate: solDate) { photos in
            
            self.photos = photos
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
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
    
    convenience init(withRover roverType: RoverType) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10.0,
                                           left: 0.0,
                                           bottom: 10.0,
                                           right: 0.0)
        
        self.init(collectionViewLayout: layout)
        
        self.roverType = roverType
        title = roverType.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented for RoverPhotos_CollectionViewController")
    }
}

// MARK: - UICollectionViewDataSource

extension RoverPhotos_CollectionViewController {
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.photos.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RoverPhoto_CollectionViewCell

        if let photo = photos?.photos[indexPath.row] {
            
            roverPhoto_datasource?.getImageData(photo: photo) { data in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.photoView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        if let cameraName = photos?.photos[indexPath.row].camera.name,
            let earthDate = photos?.photos[indexPath.row].earthDate {
            
            cell.photoNameLabel.text = "\(earthDate) - \(cameraName)"
        }
        
        return cell
    }
}



// MARK: - UICollectionViewDelegate

extension RoverPhotos_CollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailViewController = RoverPhotoDetail_ViewController()
        detailViewController.photo = photos?.photos[indexPath.row]
        detailViewController.moc = moc
        if let cell = collectionView.cellForItem(at: indexPath) as? RoverPhoto_CollectionViewCell {
            detailViewController.image = cell.photoView.image
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}




// MARK: - UICollectionViewDelegateFlowLayout

extension RoverPhotos_CollectionViewController {
    
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



// MARK: - Custom CollectionView Cell for RoverCollectionViewController

class RoverPhoto_CollectionViewCell: UICollectionViewCell {
    
    let photoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.appBlue.cgColor
        view.layer.masksToBounds = true
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
        fatalError("init(coder:) has not been implemented for RoverPhoto_CollectionViewCell")
    }
}
