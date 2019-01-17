//
//  RoverSelector_ViewController.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RoverSelectorTableViewCell"

class RoverSelector_ViewController: UIViewController {

    
    let rovers:[RoverType] = [.curiosity, .opportunity, .spirit]
    
    var manifest: RoverManifest?
    var roverType: RoverType = .curiosity
    var roverPhoto_DataSource: RoverPhoto_DataSource?
    
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: self.view.bounds, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        return view
    }()
    
    let slider: UISlider = {
        let view = UISlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return view
    }()
    
    let sliderLabelLeft: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsFontSizeToFitWidth = true
        view.textColor = .white
        view.textAlignment = .right
        return view
    }()
    
    let sliderLabelRight: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsFontSizeToFitWidth = true
        view.textColor = .white
        view.textAlignment = .left
        return view
    }()
    
    let sliderLabelCenter: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsFontSizeToFitWidth = true
        view.textColor = .white
        view.textAlignment = .center
        view.text = "Select a Sol date."
        return view
    }()
    
    let showImagesButton: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.roundedRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Show Mars Images!", for: .normal)
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.addTarget(self, action: #selector(showImages), for: .touchUpInside)
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        view.tintColor = .white
        view.titleLabel?.textColor = .white
        view.layer.cornerRadius = 5.0
        return view
    }()
    
    // spacers to sandwich the UIButton so it can be centered vertically.
    let spacer1 = UILayoutGuide()
    let spacer2 = UILayoutGuide()
    
    
    
    
    // MARK: - Slider actions
    func updateSlider() {
        roverPhoto_DataSource?.getManifestFor(rover: roverType) { [weak self] manifest in
            self?.manifest = manifest
            
            DispatchQueue.main.async {
                if let firstDate = manifest?.firstSolDate,
                    let lastDate = manifest?.lastSolDate {
                    
                    self?.sliderLabelLeft.text = "\(firstDate)"
                    self?.sliderLabelRight.text = "\(lastDate)"
                    
                    self?.slider.maximumValue = Float(manifest?.photoManifest.photos.count ?? 0)
                    self?.slider.minimumValue = Float(1)
                    
                }else{
                    self?.sliderLabelLeft.text = "0"
                    self?.sliderLabelRight.text = "0"
                }
                self?.sliderValueChanged()
            }
            
        }
    }
    
    @objc func sliderValueChanged() {
        guard let photoCount = manifest?.photoManifest.photos.count,
            photoCount > 0,
            (1...photoCount) ~= Int(slider.value),
            let solDate = manifest?.photoManifest.photos[Int(slider.value)-1].sol
         else { return }
        
        sliderLabelCenter.text = "Sol Date: \(solDate)"
    }
    
    // MARK: - Button actions
    @objc func showImages() {
        
        let roverPhotos_CollectionViewController = RoverPhotos_CollectionViewController(withRover: roverType)
        
        roverPhotos_CollectionViewController.roverPhoto_datasource = roverPhoto_DataSource
        roverPhotos_CollectionViewController.solDate = manifest?.photoManifest.photos[Int(slider.value)-1].sol ?? 1
        
        navigationController?.pushViewController(roverPhotos_CollectionViewController, animated: true)
    }
    
    
    
    // MARK: - UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mars Rovers"
        tableView.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        [tableView,
         slider,
         sliderLabelRight,
         sliderLabelLeft,
         showImagesButton,
         sliderLabelCenter].forEach{ view.addSubview($0) }
        
        [spacer1,
         spacer2].forEach{ view.addLayoutGuide($0) }
        
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            slider.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 40),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            sliderLabelRight.heightAnchor.constraint(equalToConstant: 30),
            sliderLabelLeft.heightAnchor.constraint(equalTo: sliderLabelRight.heightAnchor),
            sliderLabelCenter.heightAnchor.constraint(equalTo: sliderLabelRight.heightAnchor),
            
            sliderLabelCenter.widthAnchor.constraint(equalTo: slider.widthAnchor, multiplier: 0.6),
            
            sliderLabelRight.topAnchor.constraint(equalTo: slider.topAnchor),
            sliderLabelLeft.topAnchor.constraint(equalTo: sliderLabelRight.topAnchor),
            sliderLabelCenter.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -10),
            
            sliderLabelRight.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sliderLabelRight.leadingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 5),
            sliderLabelLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sliderLabelLeft.trailingAnchor.constraint(equalTo: slider.leadingAnchor, constant: -5),
            sliderLabelCenter.centerXAnchor.constraint(equalTo: slider.centerXAnchor),
            
            spacer1.topAnchor.constraint(equalTo: slider.bottomAnchor),
            spacer1.bottomAnchor.constraint(equalTo: showImagesButton.topAnchor),
            spacer2.topAnchor.constraint(equalTo: showImagesButton.bottomAnchor),
            spacer2.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            spacer2.heightAnchor.constraint(equalTo: spacer1.heightAnchor),
            
            showImagesButton.widthAnchor.constraint(equalTo: slider.widthAnchor, multiplier: 0.8),
            showImagesButton.centerXAnchor.constraint(equalTo: slider.centerXAnchor),
            showImagesButton.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }

}



// MARK: - TableViewDatasource

extension RoverSelector_ViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rovers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = rovers.map{ $0.rawValue }[indexPath.row]
        
        return cell
    }
    
}


// MARK: - TableViewDelegate

extension RoverSelector_ViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        roverType = rovers[indexPath.row]
        
        updateSlider()

    }
    
}
