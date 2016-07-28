//
//  ListCitiesWeatherViewController.swift
//  Weather
//
//  Created by George Cavalcanti on 7/27/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import UIKit
import CoreLocation

class ListCitiesWeatherViewController: UITableViewController {
    
    let segueIdShowDetail: String = "ShowDetailsSegue"
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var tbHeaderStatus: UIView!
    
    private var listCities: [CityWeather] = []
    private var selectedCity: CityWeather?
    
    private let presenter = ListCitiesPresenter()
    
    var selectedCoordinate: CLLocationCoordinate2D?
    
    
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
        
        presenter.attachView(self)
        
        presenter.getCities(selectedCoordinate!)
        
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

extension ListCitiesWeatherViewController: ListCitiesView {
    
    func startLoading() {
        tableView.tableHeaderView = tbHeaderStatus
        activityIndicator.startAnimating()
        lbStatus.text = "Carregando..."
    }
    
    func finishLoading() {
        activityIndicator.stopAnimating()
        tbHeaderStatus.hidden = true
        tableView.tableHeaderView = nil
    }
    
    func setCities(cities: [CityWeather]) {
        self.listCities = cities
        self.tableView.reloadData()
    }
    
    func showError(error: ErrorType) {
        
    }
    
    func showNoCity() {
        tableView.tableHeaderView = tbHeaderStatus
        tbHeaderStatus.hidden = false
        lbStatus.text = "Nenhuma cidade encontrada."
    }
    
}
