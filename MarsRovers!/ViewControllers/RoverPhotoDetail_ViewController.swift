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
    
    var photo: Photo?
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

        if let photo = photo {

            earthDateLabel.text = "Earth Date: \(photo.earthDate)"
            solDateLabel.text = "Sol Date: \(photo.sol)"
            cameraLabel.text = photo.camera.fullName
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
        
        if let imgURLString = photo?.imgSrc,
            let moc = moc {
            
            if existsInCoreData(imgURLString: imgURLString, moc: moc) {
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
            cameraLabel.heightAnchor.constraint(equalToConstant: 40),
            
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
        
        let zoomedVIewController = FullScreenImage_ViewController()
        zoomedVIewController.image = photoView.image
        zoomedVIewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(zoomedVIewController, animated: true)
    }
    
    @objc func toggleLikeButton() {
        
        guard let moc = moc,
            let imgURLString = photo?.imgSrc,
            let iconEmoji = likeButton.titleLabel?.text
            else { return }
        
        if let likeIcon = Icon(rawValue: iconEmoji) {
            
            switch likeIcon {
                
            case .like:
                
                deleteFromCoreData(imgURLString: imgURLString, moc: moc)
                likeButton.setTitle(Icon.unlike.rawValue, for: .normal)
                
            case .unlike:
                
                insertIntoCoreData(imgURLString: imgURLString, moc: moc)
                likeButton.setTitle(Icon.like.rawValue, for: .normal)
            }
        }
    }
    
    
    // MARK: - Core Data helpers
    func insertIntoCoreData(imgURLString: String, moc: NSManagedObjectContext) {
        do {
            let newObject = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRoverImage", into: moc)
            newObject.setValue(imgURLString, forKey: "urlString")
            try moc.save()
            
        }catch{
            print("error inserting into core data")
        }
    }
    
    func existsInCoreData(imgURLString: String, moc: NSManagedObjectContext) -> Bool {
        let fetchRequest:NSFetchRequest = FavoriteRoverImage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "urlString=='\(imgURLString)'")
        do {
            let count = try moc.count(for: fetchRequest)
            return count > 0
        }catch{
            return false
        }
    }
    
    func deleteFromCoreData(imgURLString: String, moc: NSManagedObjectContext) {
        let fetchRequest:NSFetchRequest = FavoriteRoverImage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "urlString=='\(imgURLString)'")
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
