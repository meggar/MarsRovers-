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
        view.backgroundColor = blue
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
        }

        stackTop.addSubview(photoView)
        
        [earthDateLabel,
         solDateLabel,
         cameraLabel].forEach{ stackView.addArrangedSubview($0) }
        
        stackBottom.addSubview(stackView)
        
        [stackTop,
         stackBottom].forEach{ stack.addArrangedSubview($0) }
        
        view.addSubview(stack)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Zoom",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(zoomPhoto))
        
        stack.axis = UIDevice.current.orientation.isLandscape ? .horizontal : .vertical
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
            stackView.trailingAnchor.constraint(equalTo: stackBottom.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: stackBottom.topAnchor, constant: 10),
            
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
    
    // MARK: - button handler
    @objc func zoomPhoto() {
        
        let zoomedVIewController = FullScreenImage_ViewController()
        zoomedVIewController.image = photoView.image
        zoomedVIewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(zoomedVIewController, animated: true)
    }
}
