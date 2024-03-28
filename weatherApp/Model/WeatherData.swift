//
//  WeatherData.swift
//  weatherApp
//
//  Created by Alijon Jumayev on 3/26/24.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
