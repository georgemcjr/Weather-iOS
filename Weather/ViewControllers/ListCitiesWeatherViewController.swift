//
//  ListCitiesWeatherViewController.swift
//  Weather
//
//  Created by George Cavalcanti on 7/27/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import UIKit

class ListCitiesWeatherViewController: UITableViewController {
    
    let segueIdShowDetail: String = "ShowDetailsSegue"
    
    var listCities: [CityWeather] = []
    var selectedCity: CityWeather?
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup
    func initialSetup() {
        
        for i in 1..<10 {
            let city = CityWeather(cityName: "Name \(i)", minTemperature: 10, maxTemperature: 20, weatherDescription: "Good!")
            listCities.append(city)
        }
        
    }
    
    
    // MARK: - Tableview datasource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityCellId", forIndexPath: indexPath)
        
        cell.textLabel?.text = listCities[indexPath.row].cityName
        cell.detailTextLabel?.text = listCities[indexPath.row].weatherDescription
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCities.count
    }
    
    override  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - Tableview delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedCity = listCities[indexPath.row]
        
        performSegueWithIdentifier(segueIdShowDetail, sender: self)
    }
    
    
     // MARK: - Navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueIdShowDetail {
            if let nextVC = segue.destinationViewController as? CityWeatherDetailViewController {
                if let selectedCity = self.selectedCity {
                    nextVC.currentCity = selectedCity
                }
            }
        }
     }
    
    

}
