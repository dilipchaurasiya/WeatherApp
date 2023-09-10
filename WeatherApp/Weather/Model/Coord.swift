//
//  Coord.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 09/09/23.
//

import Foundation

struct Coord : Codable {
    let lon : Double?
    let lat : Double?

    enum CodingKeys: String, CodingKey {

        case lon = "lon"
        case lat = "lat"
    }

}
