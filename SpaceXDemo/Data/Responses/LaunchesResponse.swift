//
//  LaunchesResponse.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import Foundation

struct LaunchesResponse: Codable, CustomStringConvertible {

    var flight_number: Int?
    var mission_name: String?
    var launch_date_unix: Double?
    var rocket: RocketModel?

    func getDateLaunchDate() -> Date? {
        if let launch_date_unix = launch_date_unix {
            return Date(timeIntervalSince1970: launch_date_unix)
        }
        return nil
    }
}

struct RocketModel: Codable, CustomStringConvertible {

    var rocket_id: String?
    var rocket_name: String?
    var rocket_type: String?
    var imageUrl: String?
}
