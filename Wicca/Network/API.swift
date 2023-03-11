//
//  API.swift
//  MyBestLife
//
//  Created by Jay Jariwala on 08/10/20.
//  Copyright © 2020 Jay Jariwala. All rights reserved.
//

/*
import Foundation
import Moya
import Alamofire

let baseUrl = "https://admin.nouvelletaverne.fr/userApi/"
let websocketUrl = "https://51.91.22.176:3003"
enum API {
    case login(email: String, password: String, login_by: String, device_type: String, device_token: String)
}

extension API : TargetType
{
    var baseURL: URL {
        switch self {
        case .login:
            return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password, let login_by, let device_type, let device_token):
            return .requestParameters(
                parameters: [
                    "email": email,
                    "password": password,
                    "login_by": login_by,
                    "device_type": device_type,
                    "device_token": "123456"],
                encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        
        switch path {
        case "updateProfile":
             return ["Content-type" : "multipart/form-data","language" : LCLDefaultLanguage]
        default:
            return ["Content-Type": "application/json", "language" : LCLDefaultLanguage]
        }
       
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

private extension String {
    var utf8Encoded: Data { return data(using: .utf8)! }
}
*/
