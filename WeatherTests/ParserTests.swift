//
//  ParserTests.swift
//  Weather
//
//  Created by George Cavalcanti on 7/27/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Weather

class ParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCityWeatherParser() {
        
        let expectation = expectationWithDescription("Ready verification!")
        
        let coordinate = CLLocationCoordinate2D(latitude: -13.104694390162194, longitude: -43.014375473117717)
        
        NetworkManager.requestWeatherInLocation(coordinate) { (json, error) in
            
            XCTAssertNotNil(json, error.debugDescription)
            
            if let listDictCities = json!["list"] as AnyObject as? [[String: AnyObject]] {
                XCTAssertEqual(listDictCities.count, NetworkManager.ApiConfig.numOfCitiesAround)
                
                let cityMock = CityWeather.fromJson(listDictCities[0])
                
                XCTAssertNotNil(cityMock, "Parser error")
            
            }
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "Timeout expectation")
        }
        
    }
    
}
