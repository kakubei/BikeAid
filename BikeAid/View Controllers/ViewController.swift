//
//  ViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 01/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    let bikeModel = BikeModel()
    let detailsSegue = "DetailsSegue"
    var currentBike: Bike?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }

    private func configure() {        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let currentBike = self.currentBike,
            segue.identifier == self.detailsSegue
        else {
            return
        }
            let destinationVC = segue.destination as? DetailsVC
            destinationVC?.bike = currentBike
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bikeModel.bikes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.textLabel?.text = self.bikeModel.titleLabel(for: indexPath)
        cell.detailTextLabel?.text = self.bikeModel.typeLabel(for: indexPath)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentBike = self.bikeModel.bikes[indexPath.row]
        performSegue(withIdentifier: self.detailsSegue, sender: self)
    }
}
