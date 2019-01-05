//
//  RoverPhotos_CollectionViewController.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RoverCollectionViewCell"



class RoverPhotos_CollectionViewController: UICollectionViewController {

    var photos: Photos?
    
    

    // MARK: UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.photos.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RoverPhoto_CollectionViewCell
    
        if let imgSrc = photos?.photos[indexPath.row].imgSrc,
            let imageUrl = URL(string: imgSrc) {
            
            cell.setImageData(url: imageUrl)
        }
    
        return cell
    }
    
}



// MARK: - Custom CollectionView Cell for RoverCollectionViewController

class RoverPhoto_CollectionViewCell: UICollectionViewCell {
    
    let photoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let photoNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            photoNameLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor),
            photoNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    func setImageData(url: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async { [weak self] in
                    self?.photoView.image = UIImage(data: data)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented for RoverPhoto_CollectionViewCell")
    }
}
