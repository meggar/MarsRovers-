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
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: self.view.bounds, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        return view
    }()
    
    let rovers:[RoverType] = [.curiosity, .opportunity, .spirit]
    
    

    // MARK: - UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mars Rovers"
        tableView.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
        
        let roverPhotos_CollectionViewController = RoverPhotos_CollectionViewController(withRover: rovers[indexPath.row])
        
        roverPhotos_CollectionViewController.roverPhoto_datasource = FakeRoverPhotoAPI()
        //roverPhotos_CollectionViewController.roverPhoto_datasource = NasaRoverPhotoAPI(httpClient: HTTPClient())
        
        navigationController?.pushViewController(roverPhotos_CollectionViewController, animated: true)
    }
    
}
