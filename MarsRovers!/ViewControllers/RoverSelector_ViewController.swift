//
//  RoverSelector_ViewController.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/5/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RoverSelectorTableViewCell"
private let fontNormal = UIFont(name: "AvenirNext-Medium", size: 20.0)
private let fontSmall = UIFont(name: "AvenirNext-Light", size: 14.0)
private let fontBold = UIFont(name: "AvenirNext-Bold", size: 20.0)
private let white = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
private let blue = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)

class RoverSelector_ViewController: UIViewController {

    
    let rovers:[RoverType] = [.curiosity, .opportunity, .spirit]
    
    var manifest: RoverManifest?
    var roverType: RoverType = .curiosity
    var roverPhoto_DataSource: RoverPhoto_DataSource?
    
    
    let stack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = blue
        return view
    }()
    
    let stackBottom: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: self.view.bounds, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var roverDescription: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = fontNormal
        view.textColor = white
        view.backgroundColor = .clear
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    let slider: UISlider = {
        let view = UISlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        view.thumbTintColor = white
        view.minimumTrackTintColor = blue
        view.maximumTrackTintColor = blue
        view.isEnabled = false
        return view
    }()
    
    let sliderLabelLeft: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsFontSizeToFitWidth = true
        view.textColor = white
        view.font = fontSmall
        view.textAlignment = .right
        return view
    }()
    
    let sliderLabelRight: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsFontSizeToFitWidth = true
        view.textColor = white
        view.font = fontSmall
        view.textAlignment = .left
        return view
    }()
    
    let sliderLabelCenter: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsFontSizeToFitWidth = true
        view.textColor = white
        view.font = fontSmall
        view.textAlignment = .center
        view.text = ""
        return view
    }()
    
    let sliderAdustLeft: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.setTitle("⇦", for: .normal)
        view.tintColor = blue
        view.addTarget(self, action: #selector(decrementSliderValue), for: .touchUpInside)
        view.isEnabled = false
        return view
    }()
    
    let sliderAdjustRight: UIButton = {
        let view = UIButton(type: .roundedRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.setTitle("⇨", for: .normal)
        view.tintColor = blue
        view.addTarget(self, action: #selector(incrementSliderValue), for: .touchUpInside)
        view.isEnabled = false
        return view
    }()
    
    let showImagesButton: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.roundedRect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Show Mars Images!", for: .normal)
        view.setTitleColor(white, for: .normal)
        view.setTitleColor(blue, for: UIControl.State.disabled)
        view.titleLabel?.font = fontBold
        view.backgroundColor = blue
        view.tintColor = white
        view.titleLabel?.textColor = white
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.addTarget(self, action: #selector(showImages), for: .touchUpInside)
        view.layer.cornerRadius = 5.0
        view.isEnabled = false
        return view
    }()
    
    // spacers to sandwich the UIButton so it can be centered vertically.
    let spacer1 = UILayoutGuide()
    let spacer2 = UILayoutGuide()
    
    
    
    
    // MARK: - Slider actions
    func updateSlider() {
        
        toggleSliderAndButton(enabled: false)
        roverDescription.text = ""
        
        roverPhoto_DataSource?.getManifestFor(rover: roverType) { [weak self] manifest in
            
            self?.manifest = manifest
            
            DispatchQueue.main.async {
                if let firstDate = manifest?.firstSolDate,
                    let lastDate = manifest?.lastSolDate {
                    
                    self?.sliderLabelLeft.text = "\(firstDate)"
                    self?.sliderLabelRight.text = "\(lastDate)"
                    
                    self?.slider.maximumValue = Float(manifest?.photoManifest.photos.count ?? 0)
                    self?.slider.minimumValue = Float(1)
                
                    self?.sliderValueChanged()
                    self?.toggleSliderAndButton(enabled: true)
                    
                    self?.roverDescription.text = manifest?.photoManifest.roverDescriptionText()
                }
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
    
    private func toggleSliderAndButton(enabled: Bool) {
        
        [slider,
        showImagesButton,
        sliderAdustLeft,
        sliderAdjustRight].forEach{ $0.isEnabled = enabled }
        
        if !enabled {
            [sliderLabelLeft,
            sliderLabelRight,
            sliderLabelCenter].forEach{ $0.text = "" }
        }
    }
    
    @objc func incrementSliderValue() {
        let newValue = min(slider.value + 1.0, slider.maximumValue)
        slider.setValue(newValue, animated: true)
        sliderValueChanged()
    }
    
    @objc func decrementSliderValue() {
        let newValue = max(slider.value - 1.0, slider.minimumValue)
        slider.setValue(newValue, animated: true)
        sliderValueChanged()
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
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {

        [slider,
         sliderLabelRight,
         sliderLabelLeft,
         showImagesButton,
         sliderLabelCenter,
         sliderAdustLeft,
         sliderAdjustRight].forEach{ stackBottom.addSubview($0) }
        
        [spacer1,
         spacer2].forEach{ stackBottom.addLayoutGuide($0) }
        
        [tableView, roverDescription].forEach{ stackTop.addSubview($0) }
        
        stack.addArrangedSubview(stackTop)
        stack.addArrangedSubview(stackBottom)
        view.addSubview(stack)
        
        stack.axis = UIDevice.current.orientation.isLandscape ? .horizontal : .vertical
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            // TableView
            tableView.topAnchor.constraint(equalTo: stackTop.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: roverDescription.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: stackTop.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: stackTop.trailingAnchor),
            
            // Rover Description
            roverDescription.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            roverDescription.bottomAnchor.constraint(equalTo: stackTop.bottomAnchor, constant: -20),
            roverDescription.leadingAnchor.constraint(equalTo: stackTop.leadingAnchor, constant: 20),
            roverDescription.trailingAnchor.constraint(equalTo: stackTop.trailingAnchor, constant: -20),
            roverDescription.heightAnchor.constraint(equalTo: tableView.heightAnchor, multiplier: 0.6),
            
            // Slider
            slider.topAnchor.constraint(equalTo: stackBottom.topAnchor, constant: 50),
            slider.leadingAnchor.constraint(equalTo: stackBottom.leadingAnchor, constant: 40),
            slider.trailingAnchor.constraint(equalTo: stackBottom.trailingAnchor, constant: -40),
            
            // Slider Labels
            sliderLabelRight.heightAnchor.constraint(equalToConstant: 30),
            sliderLabelRight.topAnchor.constraint(equalTo: slider.topAnchor),
            sliderLabelRight.leadingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 5),
            sliderLabelRight.trailingAnchor.constraint(equalTo: stackBottom.trailingAnchor),
            
            sliderLabelLeft.heightAnchor.constraint(equalTo: sliderLabelRight.heightAnchor),
            sliderLabelLeft.topAnchor.constraint(equalTo: sliderLabelRight.topAnchor),
            sliderLabelLeft.leadingAnchor.constraint(equalTo: stackBottom.leadingAnchor),
            sliderLabelLeft.trailingAnchor.constraint(equalTo: slider.leadingAnchor, constant: -5),
            
            sliderLabelCenter.widthAnchor.constraint(equalTo: slider.widthAnchor, multiplier: 0.6),
            sliderLabelCenter.heightAnchor.constraint(equalTo: sliderLabelRight.heightAnchor),
            sliderLabelCenter.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -10),
            sliderLabelCenter.centerXAnchor.constraint(equalTo: slider.centerXAnchor),
            
            // Slider Adjust Buttons
            sliderAdustLeft.widthAnchor.constraint(equalTo: sliderLabelLeft.widthAnchor),
            sliderAdustLeft.heightAnchor.constraint(equalTo: sliderLabelLeft.heightAnchor),
            sliderAdustLeft.topAnchor.constraint(equalTo: sliderLabelLeft.bottomAnchor),
            sliderAdustLeft.trailingAnchor.constraint(equalTo: sliderLabelLeft.trailingAnchor),
            
            sliderAdjustRight.widthAnchor.constraint(equalTo: sliderAdustLeft.widthAnchor),
            sliderAdjustRight.heightAnchor.constraint(equalTo: sliderAdustLeft.heightAnchor),
            sliderAdjustRight.topAnchor.constraint(equalTo: sliderAdustLeft.topAnchor),
            sliderAdjustRight.leadingAnchor.constraint(equalTo: sliderLabelRight.leadingAnchor),
            
            // Show Mars Images! Button
            spacer1.topAnchor.constraint(equalTo: slider.bottomAnchor),
            spacer1.bottomAnchor.constraint(equalTo: showImagesButton.topAnchor),
            spacer2.topAnchor.constraint(equalTo: showImagesButton.bottomAnchor),
            spacer2.bottomAnchor.constraint(equalTo: stackBottom.bottomAnchor),
            spacer2.heightAnchor.constraint(equalTo: spacer1.heightAnchor),
            
            showImagesButton.widthAnchor.constraint(equalTo: slider.widthAnchor, multiplier: 0.8),
            showImagesButton.heightAnchor.constraint(equalToConstant: 100),
            showImagesButton.centerXAnchor.constraint(equalTo: slider.centerXAnchor),
            
            // Main StackView
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
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
}



// MARK: - TableViewDatasource

extension RoverSelector_ViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rovers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = rovers.map{ $0.rawValue }[indexPath.row]
        cell.textLabel?.font = fontSmall
        cell.textLabel?.textColor = blue
        
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
