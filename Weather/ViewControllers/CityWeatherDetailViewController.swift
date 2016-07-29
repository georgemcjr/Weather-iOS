//
//  CityWeatherDetailViewController.swift
//  Weather
//
//  Created by George Cavalcanti on 7/27/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import UIKit

class CityWeatherDetailViewController: UIViewController {

    @IBOutlet weak var lbCityName: UILabel!
    @IBOutlet weak var lbWeatherDescription: UILabel!
    @IBOutlet weak var lbMinTemperature: UILabel!
    @IBOutlet weak var lbMaxTemperature: UILabel!
    
    
    var currentCity: CityWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData() {
        lbCityName.text = currentCity!.cityName
        lbWeatherDescription.text = currentCity!.weatherDescription
        lbMinTemperature.text = String(currentCity!.minTemperature).celciusUnit()
        lbMaxTemperature.text = String(currentCity!.maxTemperature).celciusUnit()
    }

}

extension String {
    
    func celciusUnit() -> String {
        return "\(self) ºC"
    }
}
