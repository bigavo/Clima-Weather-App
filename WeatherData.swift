//
//  WeatherData.swift
//  Clima
//
//  Created by Trinh Tran on 5.9.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

public struct WeatherData: Codable {
    public let name: String
    public let main: Main
    public let weather: [Weather]
}

public struct Main: Codable {
    public let temp: Double
}

public struct Weather: Codable {
    public let description: String
    public let id: Int
}

