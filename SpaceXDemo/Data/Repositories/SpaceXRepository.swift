//
//  SpaceXRepository.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import Moya

protocol ISpaceXRepository {

    func allLaunches(
        limit: Int,
        offset: Int,
        callback: @escaping ((Result<[LaunchesResponse]>) -> Void)
    )
    func upcomingLaunches(
        limit: Int,
        offset: Int,
        callback: @escaping ((Result<[LaunchesResponse]>) -> Void)
    )

    func launchDetails(
        flightNumber: Int,
        callback: @escaping ((Result<LaunchesResponse>) -> Void)
    )
}

class SpaceXRepository: BaseRepository<SpaceXService>, ISpaceXRepository {

    func allLaunches(
        limit: Int,
        offset: Int,
        callback: @escaping ((Result<[LaunchesResponse]>) -> Void)) {
        mRequest(.all_launches(limit: limit, offset: offset), callback: callback)
    }

    func upcomingLaunches(
        limit: Int,
        offset: Int,
        callback: @escaping ((Result<[LaunchesResponse]>) -> Void)) {
        mRequest(.upcoming_launches(limit: limit, offset: offset), callback: callback)
    }

    func launchDetails(flightNumber: Int, callback: @escaping ((Result<LaunchesResponse>) -> Void)) {
        mRequest(.launch_detail(flightNumber: flightNumber), callback: callback)
    }
}
