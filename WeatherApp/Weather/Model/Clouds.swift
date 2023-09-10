//
//  Clouds.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 09/09/23.
//

import Foundation

struct Clouds : Codable {
    let all : Int?

    enum CodingKeys: String, CodingKey {

        case all = "all"
    }

}
