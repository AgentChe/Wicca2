//
//  Network.swift
//  MyBestLife
//
//  Created by Jay Jariwala on 08/10/20.
//  Copyright © 2020 Jay Jariwala. All rights reserved.
//

/*
import Foundation
import Moya
import Alamofire

struct Network {
    static var provider = MoyaProvider<API>()
    
    @discardableResult
    static func request<T>(
        _ target: API,
        decodeType type: T.Type,
        decoder: JSONDecoder = JSONDecoder(),
        dispatchQueue: DispatchQueue? = nil,
        success successCallback: @escaping (_ data: T) -> Void,
        error errorCallback: @escaping (_ message: String) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void,
        completion completionCallback: @escaping () -> Void) -> Cancellable where T: Decodable {
        
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .customISO8601
        
        let cancellableRequest = provider.request(target, callbackQueue: nil, progress: { (_ in) in})
        { (result) in
            switch result {
            case let .success(response):
                let statusCode = HTTPStatusCode(rawValue: response.statusCode) ?? HTTPStatusCode.ok
                if !statusCode.isSuccess {
                    let string = try? response.mapString()
                    let message = string ?? "no string error"
                    errorCallback(message)
                    return
                }
                do {
                    let result = try decoder.decode(T.self, from: response.data)
                    successCallback(result)
                }
                catch let error {
                    debugPrint(error.localizedDescription)
                }
            case let .failure(error):
                debugPrint(error.localizedDescription)
                failureCallback(error)
            }
        }
        return cancellableRequest
    }
    
    @discardableResult
    static func request(
        _ target: API,
        decoder: JSONDecoder = JSONDecoder(),
        dispatchQueue: DispatchQueue? = nil,
        success successCallback: @escaping (_ data: JSON) -> Void,
        error errorCallback: @escaping (_ message: String) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void) -> Cancellable {
        
        debugPrint("API:")
        debugPrint(target.baseURL.absoluteString + target.path)
        debugPrint("Header:")
        debugPrint(target.headers ?? [:])
        debugPrint("Parameters:")
        debugPrint(target)
        
        let cancellableRequest = provider.request(target, callbackQueue: nil, progress: { (_ in) in})
        { (result) in
            switch result {
            case let .success(response):
                let statusCode = HTTPStatusCode(rawValue: response.statusCode) ?? HTTPStatusCode.ok
                if !statusCode.isSuccess {
                    let string = try? response.mapString()
                    let message = string ?? "no string error"
                    errorCallback(message)
                    return
                }
                do {
                    let jSon = try JSON(data: response.data)
                    successCallback(jSon)
                }
                catch let error {
                    debugPrint(error.localizedDescription)
                }
            case let .failure(error):
                debugPrint(error.localizedDescription)
                failureCallback(error)
            }
        }
        return cancellableRequest
    }
    
}
*/
