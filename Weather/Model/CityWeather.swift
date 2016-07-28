//
//  CityWeather.swift
//  Weather
//
//  Created by George Cavalcanti on 7/27/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import UIKit

struct CityWeather {
    
    let cityName: String
    let minTemperature: Int
    let maxTemperature: Int
    let weatherDescription: String
    
}

extension CityWeather: Parselable {
    
    static func fromJson(json: [String : AnyObject]) -> CityWeather? {
        
        guard let
            mainDict = json["main"] as? [String : AnyObject],
            weatherDict = json["weather"] as? [[String : AnyObject]]
        else {
            return nil
        }
        
        guard let
            name = json["name"] as? String,
            minTemp = mainDict["temp_min"] as? Int,
            maxTemp = mainDict["temp_max"] as? Int,
            description = weatherDict.isEmpty ? "" : weatherDict[0]["description"] as? String
        else {
            return nil
        }
        
        let result = CityWeather(cityName: name, minTemperature: minTemp, maxTemperature: maxTemp, weatherDescription: description)
        
        return result
    }
}
