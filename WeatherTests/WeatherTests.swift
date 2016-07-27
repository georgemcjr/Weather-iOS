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

class WeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestWeatherSuccess() {
        
        let expectation = expectationWithDescription("Ready verification!")
        
        let coordinate = CLLocationCoordinate2D(latitude: -13.104694390162194, longitude: -43.014375473117717)
        
        NetworkManager.requestWeatherInLocation(coordinate) { (data, error) in
            print(data)
            XCTAssertNotNil(data, error.debugDescription)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertNil(error, "Timeout expectation")
        }
        
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
