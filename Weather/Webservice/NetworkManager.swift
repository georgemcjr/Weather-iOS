//
//  NetworkManager.swift
//  Weather
//
//  Created by George Cavalcanti on 7/26/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkManager: AnyObject {
    
    static let defaultAppId: String = "177939944cec2d9ed3521fba8f2dc7d6"
    
    static var numOfCitiesAround: Int = 15
    static var appId: String = defaultAppId
    static var units: String = "metric"
        
    struct QueryParams {
        static let lat = "lat"
        static let lon = "lon"
        static let numCitiesAround = "cnt"
        static let appId = "APPID"
        static let units = "units"
    }
    
    struct ServerEndpoints {
        
        //	Example: "http://api.openweathermap.org/data/2.5/find?lat={LAT}&lon={LON}&cnt=15&APPID=<APP_ID>."
        
        static let baseUrlStr = "http://api.openweathermap.org/data/2.5/find?"
        
        static let baseUrl = NSURL(string: baseUrlStr)!
        
        static func getUrlComponents() -> NSURLComponents {
            let urlComponents = NSURLComponents(URL: ServerEndpoints.baseUrl, resolvingAgainstBaseURL: false)!
            return urlComponents
        }
        
    }
    
    
    static func requestWeatherInLocation(coordinate: CLLocationCoordinate2D, callback: (AnyObject?, ErrorType?) -> ()) {
        
        let request = NSMutableURLRequest(URL: mountUrlRequest(coordinate)!)
        
        requestJSON(request) { (jsonData, error) in
            
            if error != nil  {
                callback(nil, error!)
                return
            }
            
            if let data = jsonData as? NSData {
                let parsedJson = Parser.parse(data)
                callback(parsedJson, nil)
            } else {
                // No data returned from server and no error occurred
                callback(nil, nil)
            }
            
        }
        
    }
    
    
    static func requestJSON(request:NSMutableURLRequest, callback:(AnyObject?, ErrorType?) -> ()) {
        
        let urlSession = NSURLSession.sharedSession()
        
        let dataTask = urlSession.dataTaskWithRequest(request) { (data, response, error) in
            
            if error != nil  {
                callback(nil, NetworkError.FatalError((error?.localizedDescription)!))
                return
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                
                switch httpResponse.statusCode {
                    
                case 200..<300:
                    callback(data ?? nil, nil)
                    return
                case 401:
                    callback(nil, NetworkError.Unauthorized(httpResponse.statusCode))
                case 404:
                    callback(nil, NetworkError.NotFound(httpResponse.statusCode))
                case let code where code >= 500:
                    callback(nil, NetworkError.ServerError(httpResponse.statusCode))
                default:
                    callback("Unknown error", NetworkError.Unknown)
                }
                
            } else {
                callback("No server response", NetworkError.Unknown)
            }
            
        }
        
        dataTask.resume()
        
    }
    
    static func mountUrlRequest(coordinate: CLLocationCoordinate2D) -> NSURL? {
        
        let latitude = String(coordinate.latitude)
        let longitude = String(coordinate.longitude)
        
        
        let queryLat = NSURLQueryItem(name: QueryParams.lat, value: latitude)
        let queryLon = NSURLQueryItem(name: QueryParams.lon, value: longitude)
        let queryNumCitiesAround = NSURLQueryItem(name: QueryParams.numCitiesAround, value: String(numOfCitiesAround))
        let queryUnits = NSURLQueryItem(name: QueryParams.units, value: units)
        let queryAppId = NSURLQueryItem(name: QueryParams.appId, value: appId)
        
        let urlComponents = ServerEndpoints.getUrlComponents()
        
        urlComponents.queryItems?.append(queryLat)
        urlComponents.queryItems?.append(queryLon)
        urlComponents.queryItems?.append(queryNumCitiesAround)
        urlComponents.queryItems?.append(queryUnits)
        
        urlComponents.queryItems?.append(queryAppId)
        
        
        return urlComponents.URL
        
        
    }
    
}







