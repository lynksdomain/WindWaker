//
//  Weather.swift
//  WindWaker
//
//  Created by C4Q on 9/11/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct Response: Codable {
    let response: [PeriodWrapper]
}

struct PeriodWrapper: Codable {
    let periods: [Weather]
}

struct Weather: Codable {
    let timestamp: Int
    let maxTempF: Int
    let maxTempC: Int
    let minTempF: Int
    let minTempC: Int
    let icon: String
}

