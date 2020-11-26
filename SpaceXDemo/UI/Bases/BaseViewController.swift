//
//  BaseViewController.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 24.11.2020.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    var activityIndicator: CustomProgressView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProgressView()
        initialComponents()
        registerEvents()
        createdUIInitWithEvents()
    }
    
    func initialComponents() {
        preconditionFailure("initialComponents - This method must be overridden")
    }
    
    // Optional - override
    func registerEvents() { }
    
    // Optional - override
    func createdUIInitWithEvents() { }

}

// MARK: API Response Handle & Exceptions Handle
extension BaseViewController {
    
    // MARK: observeAPIState
    func observeAPIState<CONTENT: Codable>(
        apiState: PublishSubject<APIState<CONTENT>>,
        apiErrorHandler: BaseApiErrorHandler? = nil,
        callbackLoading: (() -> Void)? = nil,
        callbackSuccess: ((CONTENT) -> Void)? = nil,
        callbackComplete: ((_ isError: Bool) -> Void)? = nil
    ) {
        
        var errorHandler = apiErrorHandler
        if errorHandler ==  nil {
            errorHandler = BaseApiErrorHandler(viewController: self)
        }
        apiState
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (state) in
                switch state {
                case .Loading:
                    callbackLoading?()
                case .Success(let content):
                    callbackSuccess?(content)
                case .Error(let errorType):
                    self.handleApiError(errorType: errorType, apiErrorHandler: errorHandler!)
                case .Complete(let isError):
                    callbackComplete?(isError)
                }
            }).disposed(by: disposeBag)
    }
    
    // MARK: handleApiError
    func handleApiError(
        errorType: NetworkingError,
        apiErrorHandler: BaseApiErrorHandler
    ) {
        switch errorType {
        case .HTTP_EXCEPTION(let statusCode, _):
            if statusCode == 401 {
                apiErrorHandler.handleHttp401(errorMessage: errorType.description)
            } else if statusCode == 500 {
                apiErrorHandler.handleHttp500(errorMessage: errorType.description)
            } else {
                apiErrorHandler.handleHttpElse(errorMessage: errorType.description)
            }
        case .NO_CONNECTION_NETWORK:
            apiErrorHandler.handleNoInternet(errorMessage: errorType.description)
        case .UNDEFINED(_):
            apiErrorHandler.handleUndefined(errorMessage: errorType.description)
        case .UNDEFINED_RESPONSE_TYPE:
            apiErrorHandler.handleUndefined(errorMessage: errorType.description)
        }
    }

}

// MARK: Activity Indicator
extension BaseViewController {

    private func initProgressView() {
        activityIndicator = CustomProgressView(frame: UIScreen.main.bounds)
    }

    func showProgress() {
        DispatchQueue.delay(250) { [weak self] in
             guard let window = WindowHelper.getWindow() else { return }
            if let activityIndicator = self?.activityIndicator {
                activityIndicator.show(mView: window)
            }
        }
    }

    func hideProgress() {
        DispatchQueue.delay(250) { [weak self] in
            if let activityIndicator = self?.activityIndicator {
                activityIndicator.hide()
            }
        }
    }
}
