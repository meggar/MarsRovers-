//
//  RoverPhotoDetail_ViewController.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit

private let fontNormal = UIFont(name: "AvenirNext-Medium", size: 20.0)
private let fontBold = UIFont(name: "AvenirNext-Bold", size: 20.0)
private let white = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
private let blue = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)

class RoverPhotoDetail_ViewController: UIViewController {

    var photo: Photo?
    var image: UIImage?
    
    var photoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var earthDateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = fontBold
        view.textColor = white
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    var solDateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = fontBold
        view.textColor = white
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    var cameraLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = fontBold
        view.textColor = white
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    var textArea: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = fontNormal
        view.textColor = white
        view.backgroundColor = .clear
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
        view.backgroundColor = blue
        
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        
        photoView.image = image

        if let photo = photo {

            earthDateLabel.text = "Earth Date: \(photo.earthDate)"
            solDateLabel.text = "Sol Date: \(photo.sol)"
            cameraLabel.text = photo.camera.fullName
            textArea.text = photo.rover.description()
        }

        [earthDateLabel,
         solDateLabel,
         cameraLabel].forEach{ stackView.addArrangedSubview($0) }
        
        [photoView,
         stackView,
         textArea].forEach{ view.addSubview($0) }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Zoom",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(zoomPhoto))
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // photoView
            photoView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.35),
            photoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            // labels
            earthDateLabel.heightAnchor.constraint(equalToConstant: 40),
            solDateLabel.heightAnchor.constraint(equalToConstant: 40),
            cameraLabel.heightAnchor.constraint(equalToConstant: 40),
            
            // stackView
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 10),
        
            // textArea
            textArea.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            textArea.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textArea.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            textArea.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - button handler
    @objc func zoomPhoto() {
        
        let zoomedVIewController = FullScreenImage_ViewController()
        zoomedVIewController.image = photoView.image
        present(zoomedVIewController, animated: true)
    }

}
