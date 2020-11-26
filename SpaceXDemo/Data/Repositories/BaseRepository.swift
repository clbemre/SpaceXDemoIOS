//
//  BaseRepository.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import Moya

protocol IBaseRepository { }

class BaseRepository<Target: TargetType>: IBaseRepository {

    private var provider: MoyaProvider<Target>

    init(provider: MoyaProvider<Target>) {
        self.provider = provider
    }

    func mRequest<T: Codable>(_ target: Target, callback: @escaping (Result<T>) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                if statusCode >= 200 && statusCode < 300 {
                    do {
                        let response = try JSONDecoder().decode(T.self, from: response.data)
                        callback(Result.success(response))
                    } catch {
                        callback(Result.failure(errorType: .UNDEFINED_RESPONSE_TYPE))
                    }
                } else {
                    callback(Result.failure(errorType: .HTTP_EXCEPTION(statusCode: statusCode, message: "_-_")))
                }
            case .failure(let error):
                switch error {
                case .underlying(let underlyingError, _):
                    switch underlyingError.asAFError {
                    case .sessionTaskFailed(let sessionTaskFailedError):
                        if (sessionTaskFailedError as NSError).code == -1009 {
                            callback(Result.failure(errorType: .NO_CONNECTION_NETWORK))
                        }
                    default:
                        callback(Result.failure(errorType: .UNDEFINED(message: "")))
                    }
                default:
                    callback(Result.failure(errorType: .UNDEFINED(message: "")))
                }
            }
        }
    }

}
