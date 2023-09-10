//
//  APIError.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 09/09/23.
//

import Foundation


enum APIError: Error {
    case unknown
    case decodeError
    case invalidStatusCode(Int)
    case invalidResponse
    case invalidURL
}
