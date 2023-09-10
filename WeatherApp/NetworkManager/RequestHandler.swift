//
//  RequestHandler.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 09/09/23.
//

import Foundation

enum RequestBuilder {
    case weatherDataUsingLatLong(lat: Double, long: Double)
    case weatherDataUsingCityName(name: String)
}

extension RequestBuilder: Endpoint {
    var path: String {
        switch self {
        case .weatherDataUsingCityName, .weatherDataUsingLatLong:
            return "/data/2.5/weather"
        }
    }
    
    var body: [String : Any]? {
        return nil
    }
    
    
    var method: HttpMethod {
        switch self {
        case .weatherDataUsingCityName, .weatherDataUsingLatLong:
            return .get
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var queryParameters: [String : Any]? {
        switch self {
        case .weatherDataUsingLatLong(let lat,let long):
            return ["lat": lat, "lon": long, "appid": ApiKeys.apiKey]
        case .weatherDataUsingCityName(let name):
            return ["q": name, "appid": ApiKeys.apiKey]
            
        }
        
    }
    
    
}
