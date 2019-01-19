//
//  FullScreenImage_ViewController.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/19/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit

class FullScreenImage_ViewController: UIViewController {

    var image: UIImage?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let exitButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle( "🚀", for: .normal)
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(exitViewController), for: .touchUpInside)
        return view
    }()
    
    
    // MARK: - button handler
    @objc func exitViewController() {
        dismiss(animated: true)
    }
    
    
    // MARK: - UIView
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        view.addSubview(exitButton)
        
        imageView.image = image
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.bounds.size
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // imageView
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            // scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            // exitButton
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            exitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            exitButton.heightAnchor.constraint(equalToConstant: 50),
            exitButton.widthAnchor.constraint(equalTo: exitButton.heightAnchor),
        ])
    }
}
