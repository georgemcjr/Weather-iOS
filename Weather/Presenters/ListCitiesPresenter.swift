//
//  MapPresenter.swift
//  Weather
//
//  Created by George Cavalcanti on 7/27/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import Foundation
import CoreLocation

class ListCitiesPresenter {
    
    weak private var view: ListCitiesView?
    
    func attachView(view: ListCitiesView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func getCities(coordinate: CLLocationCoordinate2D) {
        
        self.view?.startLoading()
        NetworkManager.requestWeatherInLocation(coordinate) { [unowned self] (json, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.view?.finishLoading()
                
                if error != nil {
                    self.view?.showError(error!)
                    self.view?.showNoCity()
                    return
                }
                
                guard let
                    listDictCities = json!["list"] as? [[String: AnyObject]]
                    else {
                        self.view?.showNoCity()
                        return
                }
                
                var listCities = [CityWeather]()
                
                for dict in listDictCities {
                    if let city = CityWeather.fromJson(dict) {
                        listCities.append(city)
                    }
                }
                
                if (listCities.isEmpty) {
                    self.view?.showNoCity()
                } else {
                    self.view?.setCities(listCities)
                }
            })
            
        }
    }
    
    
}

protocol ListCitiesView : NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setCities(cities: [CityWeather])
    func showError(error: ErrorType)
    func showNoCity()
}




