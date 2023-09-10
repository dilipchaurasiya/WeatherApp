//
//  httpMethod.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 09/09/23.
//

import Foundation

enum HttpMethod: String {
    case get
    case post
    
    var method: String {rawValue.uppercased()}
}
