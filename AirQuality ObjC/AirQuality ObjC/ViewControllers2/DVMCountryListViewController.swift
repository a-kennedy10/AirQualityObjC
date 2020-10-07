//
//  DVMCountryListViewController.swift
//  AirQuality ObjC
//
//  Created by Alex Kennedy on 10/1/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class DVMCountryListViewController: UIViewController {

    //MARK: - properties
       var countries: [String] = [] {
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
           
           DVMCityAirQualityController.fetchSupportedCountries { (countries, error) in
               if let countries = countries {
                   self.countries = countries
               }
           }

       }


       
       // MARK: - Navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toStatesVC" {
               guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? DVMStatesListViewController
                else { return }
               
               let selectedCountry = countries[indexPath.row]
               destinationVC.country = selectedCountry
           }
       }
       
       func updateTableView() {
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }
}


extension DVMCountryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country
        return cell
    }
    
}
