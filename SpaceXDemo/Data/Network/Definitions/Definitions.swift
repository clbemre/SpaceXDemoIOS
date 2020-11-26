//
//  Definitions.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import Moya

// MARK: TargetType - Header
public protocol MTargetType: TargetType {

    var isAuthorization: Bool { get }
}

extension MTargetType {

    var baseURL: URL {
        return URL(string: NetworkUtil.environmentBaseURL)!
    }

    public var headers: [String: String]? {
        let headers: [String: String] = ["Content-Type": "application/json; charset=utf-8"]
        if isAuthorization {

        }

        return headers
    }

    var sampleData: Data {
        return Data()
    }
}

func createMoyaProvider2<Target: TargetType>(targetType: Target.Type) -> MoyaProvider<Target> {
    // let provider = MoyaProvider<Target>(plugins: [NetworkLoggerPlugin(configuration: .init())])
    let provider = MoyaProvider<Target>(plugins: [])
    provider.session.sessionConfiguration.timeoutIntervalForRequest = 120
    return provider
}

