//
//  SliderEntity.swift
//  AlboTest
//
//  Created by Mauricio Rodriguez on 09/04/21.
//

import Foundation

// MARK: - RequestAirports
struct RequestAirportsStruct {
    let lat: Double
    let lon: Double
    let limit: Int
    let radius: Int
    let flight: Bool
}

// MARK: - Countries
struct ResponseAirport: Codable {
    let items: [Airport]
}

// MARK: - Item
struct Airport: Codable {
    let iata, name: String
    let shortName, municipalityName: String?
    let location: Location
    let countryCode: String
}

// MARK: - Location
struct Location: Codable {
    let lat, lon: Double
}
