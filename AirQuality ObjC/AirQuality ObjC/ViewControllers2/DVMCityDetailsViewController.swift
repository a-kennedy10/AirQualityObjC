//
//  DVMCityDetailsViewController.swift
//  AirQuality ObjC
//
//  Created by Alex Kennedy on 10/1/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

import UIKit

class DVMCityDetailsViewController: UIViewController {

    //MARK: - properties
    var country: String?
    var state: String?
    var city: String?
    
    
    //MARK: - outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var airQualityLabel: UILabel!
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city,
            let state = state,
            let country = country
        else { return }
        
        DVMCityAirQualityController.fetchData(forCity: city, completion: state, completion: country) { (cityDetails) in
            if let details = cityDetails {
                self.updateViews(with: details)
            }
        }

    }

    func updateViews(with details: DVMAirQuality) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = details.city
            self.countryNameLabel.text = details.country
            self.stateNameLabel.text = details.state
            self.airQualityLabel.text = "Air Quality: \(details.pollution.airQualityIndex)"
            self.temperatureLabel.text = "Temperature: \(details.weather.temperature)"
            self.windSpeedLabel.text = "Wind Speed: \(details.weather.windSpeed)"
            self.humidityLabel.text = "Humidity: \(details.weather.humidity)"
        
        }
    }

}
