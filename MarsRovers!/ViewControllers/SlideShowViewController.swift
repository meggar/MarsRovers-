//
//  SlideShowViewController.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 2/9/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit

class SlideShowViewController: UIViewController {

    var photos:[FavoriteRoverImage] = []
    var roverPhoto_datasource: RoverPhoto_DataSource?
    var photoIndex = 0
    var timer: Timer?
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFit
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endSlideShow)))
        return view
    }()
    
    // MARK: UIView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupContraints()
        startSlideshow()
    }
    
    private func setupUI() {
        view.accessibilityIdentifier = AccessibilityIdentifier.FavoritesSlideShowView.rawValue
        view.backgroundColor = .black
        view.addSubview(imageView)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    // MARK: - image display
    @objc private func updateImage() {
        guard photos.count > 0 &&
              (0..<photos.count) ~= photoIndex
            else { return }
        
        let photo = photos[photoIndex]
            
        roverPhoto_datasource?.getImageData(photo: photo) { [weak self] data in
            if let data = data {
                DispatchQueue.main.async {
                    
                    let nextImage = UIImage(data: data)
                    if let imageView = self?.imageView {
                        UIView.transition(with: imageView,
                                      duration: 1.0,
                                      options: .transitionCrossDissolve,
                                      animations: { self?.imageView.image = nextImage })
                    }
                }
            }
        }
        photoIndex += 1
        photoIndex %= photos.count
    }
    
    private func startSlideshow() {
        
        updateImage()
        
        timer = Timer.scheduledTimer(timeInterval: 10,
                                     target: self,
                                     selector: #selector(self.updateImage),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    // MARK: - tap handler
    @objc func endSlideShow() {
        timer?.invalidate()
        
        self.dismiss(animated: true)
    }

}
