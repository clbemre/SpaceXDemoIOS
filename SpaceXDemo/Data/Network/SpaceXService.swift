//
//  SpaceXService.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import Moya

enum SpaceXService {

    case all_launches(limit: Int, offset: Int)
    case upcoming_launches(limit: Int, offset: Int)
    case launch_detail(flightNumber: Int)

}

extension SpaceXService: MTargetType {

    var path: String {
        switch self {
        case .all_launches(_, _):
            return "/launches"
        case .upcoming_launches(_, _):
            return "/launches"
            // return "/launches/upcoming" -> Boş Dönüyor.
        case .launch_detail(let flightNumber):
            return "launches/\(flightNumber)"
        }
    }

    var method: Method {
        switch self {
        case .all_launches(_, _),
             .upcoming_launches(_, _):
            return .get
        case .launch_detail(_):
            return .get
        }
    }

    var task: Task {
        switch self {
        case .all_launches(let limit, let offset),
             .upcoming_launches(let limit, let offset):
            let parameters = [
                "limit": limit,
                "offset": offset
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .launch_detail(_):
            return .requestPlain
        }
    }

    var isAuthorization: Bool {
        return false
    }
}
