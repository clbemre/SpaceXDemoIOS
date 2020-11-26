//
//  Result.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import Foundation

enum Result<T: Codable> {
    case success(T)
    case failure(errorType: NetworkingError)
}
