//
//  DVMCityListViewController.swift
//  AirQuality ObjC
//
//  Created by Alex Kennedy on 10/1/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class DVMCityListViewController: UIViewController {

    //MARK: - properties
    var state: String?
    var country: String?
    var cities: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    
    //MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
 
       //MARK: - lifecycle functions
       override func viewDidLoad() {
           super.viewDidLoad()
           tableView.delegate = self
           tableView.dataSource = self
           guard let state = state, let country = country else { return }
           
           DVMCityAirQualityController.fetchSupportedCities(inState: state, completion: country) { (cities, error) in
               if let cities = cities {
                   self.cities = cities
               }
           }
       }

       // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toCityDetailsVC" {
               guard let indexPath = tableView.indexPathForSelectedRow,
               let country = country,
               let state = state,
                   let destinationVC = segue.destination as? DVMCityDetailsViewController
                   else { return }
               
               let selectedCity = cities[indexPath.row]
               destinationVC.city = selectedCity
               destinationVC.state = state
               destinationVC.country = country
           }
       }
       
       
       func updateTableView() {
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }

}


extension DVMCityListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }
    
}
