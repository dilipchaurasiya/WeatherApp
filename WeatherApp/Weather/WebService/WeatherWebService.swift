//
//  WeatherWebService.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 10/09/23.
//

import Foundation

protocol WeatherServicable {
    func getWeatherDataUsingLatLong(lat: Double, long: Double) async -> Result<WeatherData, APIError>
    func getWeatherDataUsingCityName(name: String) async -> Result<WeatherData, APIError>
}

struct WeatherWebService: APIClient, WeatherServicable {
    
    func getWeatherDataUsingLatLong(lat: Double, long: Double) async -> Result<WeatherData, APIError> {
        return await sendRequest(endpoint: RequestBuilder.weatherDataUsingLatLong(lat: lat, long: long), responseModel: WeatherData.self)
    }
    
    func getWeatherDataUsingCityName(name: String) async -> Result<WeatherData, APIError> {
        return await sendRequest(endpoint: RequestBuilder.weatherDataUsingCityName(name: name), responseModel: WeatherData.self)
    }
        
}
