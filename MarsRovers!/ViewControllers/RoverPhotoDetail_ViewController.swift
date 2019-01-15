//
//  RoverPhotoDetail_ViewController.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit

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
        return view
    }()
    
    var solDateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cameraLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textArea: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(photoView)
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        
        setupUI()
        setupConstraints()
    }
    
    private func formatLabel(_ label: UILabel) {
        
        label.font = UIFont(name: "AvenirNext-Medium", size: 20.0)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
    }
    
    func setupUI() {
        
        photoView.image = image

        if let photo = photo {
            
            let rover = photo.rover
            let camera = photo.camera
            
            earthDateLabel.text = "Earth Date: \(photo.earthDate)"
            solDateLabel.text = "Sol Date: \(photo.sol)"
            cameraLabel.text = camera.fullName

            textArea.text = rover.description()
        }
        
        
        stackView.axis = .vertical
        stackView.spacing = 10
        
        [earthDateLabel, solDateLabel, cameraLabel].forEach{ label in
            label.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
            label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            label.adjustsFontSizeToFitWidth = true
        }
        
        textArea.font = UIFont(name: "AvenirNext-Medium", size: 20.0)
        textArea.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textArea.backgroundColor = .clear
        
        [earthDateLabel, solDateLabel, cameraLabel].forEach{ stackView.addArrangedSubview($0) }
        
        [photoView, stackView, textArea].forEach{ view.addSubview($0) }

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            photoView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.35),
            photoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            earthDateLabel.heightAnchor.constraint(equalToConstant: 40),
            solDateLabel.heightAnchor.constraint(equalToConstant: 40),
            cameraLabel.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 10),
        
            textArea.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            textArea.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textArea.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            textArea.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            ])
        
    }

}
