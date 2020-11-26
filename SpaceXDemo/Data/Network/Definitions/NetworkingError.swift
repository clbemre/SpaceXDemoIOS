//
//  NetworkingError.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import Foundation

enum NetworkingError: CustomStringConvertible {

    case NO_CONNECTION_NETWORK
    case HTTP_EXCEPTION(statusCode: Int, message: String?)
    case UNDEFINED(message: String)
    case UNDEFINED_RESPONSE_TYPE

    var description: String {
        switch self {
        case .NO_CONNECTION_NETWORK:
            return "Lütfen internet bağlantınızı kontrol ediniz!"
        case .HTTP_EXCEPTION(let statusCode, let message):
            switch statusCode {
            case 401:
                return "Yetki Hatası"
            case 406:
                return message ?? ""
            case 500:
                return "Sunucu Hatası"
            default:
                return message ?? ""
            }
        case .UNDEFINED(let message):
            return message
        case .UNDEFINED_RESPONSE_TYPE:
            return "undefined response type"
        }
    }
}
