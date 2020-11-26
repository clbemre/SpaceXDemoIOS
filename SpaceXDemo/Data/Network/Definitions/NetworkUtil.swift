//
//  NetworkUtil.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import Foundation

enum APIEnvironment {
    case dev
    case staging
    case production
}

struct NetworkUtil {
    private static let environment: APIEnvironment = .production

    static var environmentBaseURL: String {
        switch NetworkUtil.environment {
        case .production: return "https://api.spacexdata.com/v3"
        case .staging: return "https://api.spacexdata.com/v3"
        case .dev: return "https://api.spacexdata.com/v3"
        }
    }
}

