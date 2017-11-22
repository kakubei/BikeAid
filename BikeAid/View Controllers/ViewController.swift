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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }

    private func configure() {        
        
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
