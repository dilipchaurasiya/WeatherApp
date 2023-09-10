//
//  WeatherDataController.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 09/09/23.
//

import Foundation

class WeatherDataController {
    
    let service: WeatherServicable
    var weatherData: WeatherData? = nil
    var refreshData = Box(false)
    var isFetchingData = Box(false)
    var errorMessage = Box("")
    
    init(service: WeatherServicable) {
        self.service = service
    }
    
    func getWeatherDataUsinglatLong(lat: Double, long: Double, completion: ((Result<WeatherData, APIError>) -> Void)? = nil) {
        isFetchingData.value = true
        Task(priority: .userInitiated) {
            let result = await service.getWeatherDataUsingLatLong(lat: lat, long: long)
            handleResult(result: result)
            completion?(result)
        }
    }
    
    func getWeatherDataUsingCityName(name: String, completion: ((Result<WeatherData, APIError>) -> Void)? = nil) {
        isFetchingData.value = true
        Task(priority: .userInitiated) {
            let result = await service.getWeatherDataUsingCityName(name: name)
            handleResult(result: result)
            completion?(result)
        }
    }
    
    func handleResult(result: Result<WeatherData, APIError>) {
        DispatchQueue.main.async {
            self.isFetchingData.value = false
            switch result {
            case .success(let response):
                self.weatherData = response
                self.refreshData.value = true
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
        
    }
}

