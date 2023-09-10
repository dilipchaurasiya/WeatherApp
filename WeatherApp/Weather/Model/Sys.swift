//
//  Sys.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 09/09/23.
//

import Foundation

struct Sys : Codable {
    let type : Int?
    let id : Int?
    let country : String?
    let sunrise : Int?
    let sunset : Int?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case id = "id"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }

}
