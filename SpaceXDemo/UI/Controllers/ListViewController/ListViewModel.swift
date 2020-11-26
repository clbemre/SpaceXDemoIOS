//
//  ListViewModel.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import RxSwift

class ListViewModel: BaseViewModel {

    let repository: SpaceXRepository
    let allLaunchesApiState: PublishSubject<APIState<[LaunchesResponse]>> = PublishSubject()
    let upcomingLaunchesApiState: PublishSubject<APIState<[LaunchesResponse]>> = PublishSubject()

    var upcomingLaunchesResponse: [LaunchesResponse] = []

    var allLaunchesOffset: Int = 0
    var allLaunchesLimit: Int = 10

    init(repository: SpaceXRepository) {
        self.repository = repository
    }

    func fetchUpcomingLaunches() {
        self.upcomingLaunchesApiState.onNext(.Loading)
        self.repository.upcomingLaunches(limit: 20, offset: 0) { result in
            self.handleResultToAPIState(state: self.upcomingLaunchesApiState, result: result)
        }
    }
    
    func fetchAllLaunches() {
        self.allLaunchesApiState.onNext(.Loading)
        self.repository.allLaunches(limit: allLaunchesLimit, offset: allLaunchesOffset) { result in
            self.handleResultToAPIState(state: self.allLaunchesApiState, result: result)
        }
    }

    func upcomingLaunchesCount() -> Int {
        return self.upcomingLaunchesResponse.count
    }
}

extension ListViewModel {

    func processUpcomingLaunchesResponse() {
        self.mainupulateLaunchesResponse(list: &upcomingLaunchesResponse)
    }

    func mainupulateLaunchesResponse(list: inout [LaunchesResponse]) {
        for i in 0..<list.count {
            if i % 3 == 0 {
                list[i].rocket?.imageUrl = Constants.shared.dummyImageUrl1
            } else if i % 2 == 0 {
                list[i].rocket?.imageUrl = Constants.shared.dummyImageUrl2
            } else {
                list[i].rocket?.imageUrl = Constants.shared.dummyImageUrlWrong
            }
        }
    }
}
