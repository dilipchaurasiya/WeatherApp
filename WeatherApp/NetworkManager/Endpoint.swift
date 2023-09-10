//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 10/09/23.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
    var queryParameters: [String: Any]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.openweathermap.org"
    }
}
