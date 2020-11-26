//
//  CustomApiErrorHandler.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit

class CustomApiErrorHandler: BaseApiErrorHandler {
    
    private var callbackErrorHTTP401: ((String) -> Void)? = nil
    private var callbackErrorHTTP500: ((String) -> Void)? = nil
    private var callbackErrorHTTPElse: ((String) -> Void)? = nil
    private var callbackErrorNoInternet: ((String) -> Void)? = nil
    private var callbackErrorUndefined: ((String) -> Void)? = nil
    
    init(viewController: UIViewController? = nil,
         callbackErrorHTTP401: ((String) -> Void)? = nil,
         callbackErrorHTTP500: ((String) -> Void)? = nil,
         callbackErrorHTTPElse: ((String) -> Void)? = nil,
         callbackErrorNoInternet: ((String) -> Void)? = nil,
         callbackErrorUndefined: ((String) -> Void)? = nil) {
        
        super.init(viewController: viewController)
        self.callbackErrorHTTP401 = callbackErrorHTTP401
        self.callbackErrorHTTP500 = callbackErrorHTTP500
        self.callbackErrorHTTPElse = callbackErrorHTTPElse
        self.callbackErrorNoInternet = callbackErrorNoInternet
        self.callbackErrorUndefined = callbackErrorUndefined
    }
    
    override func handleHttp401(errorMessage: String) {
        if let callbackErrorHTTP401 = callbackErrorHTTP401 {
            callbackErrorHTTP401(errorMessage)
        } else {
            super.handleHttp401(errorMessage: errorMessage)
        }
    }
    
    override func handleHttp500(errorMessage: String) {
        if let callbackErrorHTTP500 = callbackErrorHTTP500 {
            callbackErrorHTTP500(errorMessage)
        } else {
            super.handleHttp500(errorMessage: errorMessage)
        }
    }
    
    override func handleHttpElse(errorMessage: String) {
        if let callbackErrorHTTPElse = callbackErrorHTTPElse {
            callbackErrorHTTPElse(errorMessage)
        } else {
            super.handleHttpElse(errorMessage: errorMessage)
        }
    }
    
    override func handleNoInternet(errorMessage: String) {
        if let callbackErrorNoInternet = callbackErrorNoInternet {
            callbackErrorNoInternet(errorMessage)
        } else {
            super.handleNoInternet(errorMessage: errorMessage)
        }
    }
    
    override func handleUndefined(errorMessage: String) {
        if let callbackErrorUndefined = callbackErrorUndefined {
            callbackErrorUndefined(errorMessage)
        } else {
            super.handleUndefined(errorMessage: errorMessage)
        }
    }
}
