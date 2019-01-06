//
//  RoverManifest_ViewController.swift
//  MarsRovers!
//
//  Created by Mike Eggar on 1/6/19.
//  Copyright © 2019 Mike Eggar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RoverManifestTableCell"

class RoverManifest_ViewController: UIViewController {    
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var manifest: RoverManifest?
    var roverType: RoverType = .curiosity
    var roverPhoto_DataSource: RoverPhoto_DataSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = roverType.rawValue
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:  reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        setupConstraints()
        
        
        roverPhoto_DataSource?.getManifestFor(rover: roverType) { manifest in
                
            self.manifest = manifest
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}


// MARK: - UITableViewDelegate
extension RoverManifest_ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let roverPhotos_CollectionViewController = RoverPhotos_CollectionViewController(withRover: roverType)
    
        roverPhotos_CollectionViewController.roverPhoto_datasource = roverPhoto_DataSource
        roverPhotos_CollectionViewController.solDate = manifest?.photoManifest.photos[indexPath.row].sol ?? 1
    
        navigationController?.pushViewController(roverPhotos_CollectionViewController, animated: true)
    }

}


// MARK: - UITableViewDataSource
extension RoverManifest_ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manifest?.photoManifest.photos.count ?? 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let item = manifest?.photoManifest.photos[indexPath.row] {
            cell.textLabel?.text = "Sol Date: \(item.sol)  \(item.totalPhotos) photos."
        }
        
        return cell
    }

}
