//
//  Wind.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 09/09/23.
//

import Foundation

struct Wind : Codable {
    let speed : Double?
    let deg : Int?
    let gust : Double?

    enum CodingKeys: String, CodingKey {

        case speed = "speed"
        case deg = "deg"
        case gust = "gust"
    }

}
