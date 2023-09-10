//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Dilip Chaurasiya on 09/09/23.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeatherServiceMock() async {
        let serviceMock = WeatherServiceMock()
        let lat = 44.34
        let long = 10.99
        let coordResult = await serviceMock.getWeatherDataUsingLatLong(lat: lat, long: long)
        
        switch coordResult {
        case .success(let result):
            XCTAssertEqual(result.coord?.lat, lat)
            XCTAssertEqual(result.coord?.lon, long)
            
        case .failure:
            XCTFail("The request should not fail")
        }
        
        
        let city = "Dubai"
        
        let cityResult = await serviceMock.getWeatherDataUsingCityName(name: city)
        
        switch cityResult {
        case .success(let result):
            XCTAssertEqual(result.name, city)
            
        case .failure:
            XCTFail("The request should not fail")
        }
        
    }
    
    func testWeatherDataControllerForLatLong() throws{
        let dataController = WeatherDataController(service: WeatherServiceMock())
        
        let expectation = expectation(description: "Fetch data from service")
        
        dataController.getWeatherDataUsinglatLong(lat: 44.34, long: 10.99) {_ in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
        
        DispatchQueue.main.async {
            
            XCTAssertEqual(dataController.weatherData?.coord?.lat, 44.34)
            XCTAssertEqual(dataController.weatherData?.coord?.lon, 10.99)
        }
        
    }
    
    func testWeatherDataControllerCity() throws{
        let dataController = WeatherDataController(service: WeatherServiceMock())
        
        let expectation = expectation(description: "Fetch data from service")
        
        dataController.getWeatherDataUsingCityName(name: "Mumbai"){_ in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
        
        DispatchQueue.main.async {
            XCTAssertEqual(dataController.weatherData?.name, "Mumbai")
        }
        
        
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class WeatherServiceMock: Mockable, WeatherServicable {
    func getWeatherDataUsingLatLong(lat: Double, long: Double) async -> Result<WeatherApp.WeatherData, WeatherApp.APIError> {
        return .success(loadJSON(filename: "test", type: WeatherData.self))
    }
    
    func getWeatherDataUsingCityName(name: String) async -> Result<WeatherApp.WeatherData, WeatherApp.APIError> {
        return .success(loadJSON(filename: "test", type: WeatherData.self))
    }
    
}
