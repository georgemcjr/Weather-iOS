//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by George Cavalcanti on 7/26/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Weather

class WebserviceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        NetworkManager.appId = NetworkManager.defaultAppId
        
        super.tearDown()
    }
    
    func testRequestWeatherSuccess() {
        
        let expectation = expectationWithDescription("Ready verification!")
        
        let coordinate = CLLocationCoordinate2D(latitude: -13.104694390162194, longitude: -43.014375473117717)
        
        NetworkManager.requestWeatherInLocation(coordinate) { (data, error) in
            XCTAssertNotNil(data, error.debugDescription)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "Timeout expectation")
        }
        
        
    }
    
    func testRequestWeatherUnauthorized() {
        
        let expectation = expectationWithDescription("Ready verification!")
        
        let coordinate = CLLocationCoordinate2D(latitude: -13.104694390162194, longitude: -43.014375473117717)
        
        NetworkManager.appId = "wrongAppId"
        
        NetworkManager.requestWeatherInLocation(coordinate) { (data, error) in
            XCTAssertNil(data)
            
            XCTAssertNotNil(error)
            
            if let error = error as? NetworkError {
                XCTAssertEqual(error.description, NetworkError.Unauthorized(401).description)
            } else {
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "Timeout expectation")
        }
        
        
    }
    
}
