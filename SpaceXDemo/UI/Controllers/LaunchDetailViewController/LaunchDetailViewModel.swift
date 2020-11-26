//
//  LaunchDetailViewModel.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import RxSwift

class LaunchDetailViewModel: BaseViewModel {

    let repository: SpaceXRepository

    let launcDetailState: PublishSubject<APIState<LaunchesResponse>> = PublishSubject()

    init(repository: SpaceXRepository) {
        self.repository = repository
    }

    func fetchLaunchDetail(flightNumber: Int) {
        self.launcDetailState.onNext(.Loading)
        self.repository.launchDetails(flightNumber: flightNumber) { (result) in
            self.handleResultToAPIState(
                state: self.launcDetailState,
                result: result)
        }
    }

} 
