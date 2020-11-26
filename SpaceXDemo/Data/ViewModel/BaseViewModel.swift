//
//  BaseViewModel.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import RxSwift

enum APIState<T: Codable> {

    case Loading
    case Success(content: T)
    case Error(errorType: NetworkingError)
    case Complete(isError: Bool)

}

protocol IBaseViewModel { }

class BaseViewModel: IBaseViewModel {

    func handleResultToAPIState<CONTENT: Codable>(
        state: PublishSubject<APIState<CONTENT>>,
        result: Result<CONTENT>
    ) {
        switch result {
        case .success(let mContent):
            state.onNext(.Complete(isError: false))
            state.onNext(.Success(content: mContent))
        case .failure(let errorType):
            state.onNext(.Complete(isError: true))
            state.onNext(.Error(errorType: errorType))
        }
    } 
}
