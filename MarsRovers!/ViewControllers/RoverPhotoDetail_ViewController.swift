//
//  RoverPhotoDetail_ViewController.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit
import CoreData


class RoverPhotoDetail_ViewController: UIViewController {

    var moc: NSManagedObjectContext?
    
    var photo: PhotoDetailProtocol?
    var image: UIImage?
    
    var stack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackBottom: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appBlue
        return view
    }()
    
    var photoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var earthDateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .appFontBold
        view.textColor = .appWhite
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    var solDateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .appFontBold
        view.textColor = .appWhite
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    var cameraLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .appFontBold
        view.textColor = .appWhite
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = 0
        return view
    }()
    
    var likeButton: UIButton = {
        var view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle(Icon.unlike.rawValue, for: .normal)
        view.addTarget(self, action: #selector(toggleLikeButton), for: .touchUpInside)
        return view
    }()
    
    var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    
    // MARK: - UIView
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(photoView)
        view.backgroundColor = .appBlue
        
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        
        photoView.image = image

        if let earthDate = photo?.photoEarthDate {
            earthDateLabel.text = "Earth Date: \(earthDate)"
        }
        if let solDate = photo?.photoSolDate {
            solDateLabel.text = "Sol Date: \(solDate)"
        }
        if let cameraFullName = photo?.photoCameraFullName,
            let rover = photo?.photoRover {
            
            cameraLabel.text = "\(rover), \(cameraFullName)"
        }

        stackTop.addSubview(photoView)
        
        [earthDateLabel,
         solDateLabel,
         cameraLabel].forEach{ stackView.addArrangedSubview($0) }
        
        [stackView,
         likeButton].forEach{ stackBottom.addSubview($0) }
        
        [stackTop,
         stackBottom].forEach{ stack.addArrangedSubview($0) }
        
        view.addSubview(stack)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Zoom",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(zoomPhoto))
        
        stack.axis = UIDevice.current.orientation.isLandscape ? .horizontal : .vertical
        
        if let photo = photo,
            let moc = moc {
            
            if existsInCoreData(photo: photo, moc: moc) {
                likeButton.setTitle(Icon.like.rawValue, for: .normal)
            }else{
                likeButton.setTitle(Icon.unlike.rawValue, for: .normal)
            }
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // photoView
            photoView.leadingAnchor.constraint(equalTo: stackTop.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: stackTop.trailingAnchor),
            photoView.topAnchor.constraint(equalTo: stackTop.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: stackTop.bottomAnchor),
            
            // labels
            earthDateLabel.heightAnchor.constraint(equalToConstant: 40),
            solDateLabel.heightAnchor.constraint(equalToConstant: 40),
            cameraLabel.heightAnchor.constraint(equalToConstant: 80),
            
            // stackView
            stackView.leadingAnchor.constraint(equalTo: stackBottom.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: stackBottom.trailingAnchor, constant: -60),
            stackView.topAnchor.constraint(equalTo: stackBottom.topAnchor, constant: 10),
            
            // Like Button
            likeButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
            likeButton.trailingAnchor.constraint(equalTo: stackBottom.trailingAnchor, constant: -10),
            likeButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Main stackView
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // The 2 halves of the StackView (stackTop, stackBottom),
            // top-bottom for vertical orientation, side by side for horizontal orientation.
            stackTop.heightAnchor.constraint(equalTo: stackBottom.heightAnchor),
            stackTop.widthAnchor.constraint(equalTo: stackBottom.widthAnchor),
            stackTop.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            stackBottom.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            stackTop.topAnchor.constraint(equalTo: stack.topAnchor),
            stackBottom.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        stack.axis = UIDevice.current.orientation.isLandscape ? .horizontal : .vertical
    }
    
    // MARK: - button handlers
    @objc func zoomPhoto() {
        
        let zoomedViewController = FullScreenImage_ViewController()
        zoomedViewController.image = photoView.image
        zoomedViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(zoomedViewController, animated: true)
    }
    
    @objc func toggleLikeButton() {
        
        guard let moc = moc,
               let photo = photo,
               let iconEmoji = likeButton.titleLabel?.text,
               let likeIcon = Icon(rawValue: iconEmoji)
            else { return }
        
        
        switch likeIcon {
            
        case .like:
            // order is important here:
            deleteImageFromDisk(photo: photo)
            deleteFromCoreData(photo: photo, moc: moc)
            likeButton.setTitle(Icon.unlike.rawValue, for: .normal)
            
            // if this image is unfavorited, jump back to the collectionVIew of favorites.
            navigationController?.popViewController(animated: true)
                
        case .unlike:
            insertIntoCoreData(photo: photo, moc: moc)
            if let image = image {
                saveImageToDisk(image: image, photo: photo)
            }
            likeButton.setTitle(Icon.like.rawValue, for: .normal)
        }
    }
    
    // MARK: - file system helpers
    private func saveImageToDisk(image: UIImage, photo: PhotoDetailProtocol) {
        
        if let filename = photo.photoURLString {
            
            let imagePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(filename).png"
        
            try? image.pngData()?.write(to: URL(fileURLWithPath: imagePath))
        }
    }
    
    private func deleteImageFromDisk(photo: PhotoDetailProtocol) {

        if let filename = photo.photoURLString {
            
            let imagePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(filename).png"
        
            try? FileManager.default.removeItem(at: URL(fileURLWithPath: imagePath))
        }
    }
    
    
    // MARK: - Core Data helpers
    func insertIntoCoreData(photo: PhotoDetailProtocol, moc: NSManagedObjectContext) {
        
        do {
            let newObject = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRoverImage", into: moc)
            
            newObject.setValue(photo.photoId, forKey: "imageId")
            newObject.setValue(photo.photoURLString, forKey: "urlString")
            newObject.setValue(photo.photoRover, forKey: "rover")
            newObject.setValue(photo.photoEarthDate, forKey: "earthDate")
            newObject.setValue(photo.photoSolDate, forKey: "solDate")
            newObject.setValue(photo.photoCameraName, forKey: "camera")
            newObject.setValue(photo.photoCameraFullName, forKey: "cameraFullname")
            
            try moc.save()
            
        }catch{
            print("error inserting into core data")
        }
    }
    
    func existsInCoreData(photo: PhotoDetailProtocol, moc: NSManagedObjectContext) -> Bool {
        
        guard let imgUrl = photo.photoURLString else { return false }
        
        let fetchRequest: NSFetchRequest = FavoriteRoverImage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "urlString=='\(imgUrl)'")
        do {
            let count = try moc.count(for: fetchRequest)
            return count > 0
        }catch{
            return false
        }
    }
    
    func deleteFromCoreData(photo: PhotoDetailProtocol, moc: NSManagedObjectContext) {
        
        guard let imgUrl = photo.photoURLString else { return }
            
        let fetchRequest: NSFetchRequest = FavoriteRoverImage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "urlString=='\(imgUrl)'")
        do {
            for object in try moc.fetch(fetchRequest) {
                moc.delete(object)
            }
            try moc.save()
        }catch{
            print("error deleting from core data")
        }
    }
}
