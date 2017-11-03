//
//  HTTPClient.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/2/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

import Foundation

typealias JSONType = [String: Any]
typealias HTTPClientSuccessCompletion = (JSONType) -> Void
typealias HTTPClientFailedCompletion = (Error) -> Void

private typealias dataTaskCompletion = (_ didSucceed: Bool, _ json: JSONType?) -> Void

enum RequestType: String {
    case GET = "GET"
    case POST = "POST"
}

protocol HTTPClientInterface {
    func execute(type: RequestType, endpoint: Endpoint, params: JSONType?, success: @escaping HTTPClientSuccessCompletion, failed: @escaping HTTPClientFailedCompletion)
}

class HTTPClient: HTTPClientInterface {
    static let sharedInstance = HTTPClient()

    func execute(type: RequestType, endpoint: Endpoint, params: JSONType?, success: @escaping HTTPClientSuccessCompletion, failed: @escaping HTTPClientFailedCompletion) {

        var request = URLRequest(url: NSURL(string: APIConstants.baseURL + endpoint.rawValue)! as URL)
        request.httpMethod = type.rawValue

        dataTask(request: request) { (didSucceed, jsonObject) in
            if let json = jsonObject, didSucceed {
                success(json)
            } else {
                // TODO: Call failed completion with error
            }
        }
    }
}

fileprivate extension Helpers {
    func dataTask(request: URLRequest, completion: @escaping dataTaskCompletion) {
        let session = URLSession(configuration: URLSessionConfiguration.default)

        session.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, json as? JSONType)
                } else {
                    // TODO: Handle errors better here
                    completion(false, json as? JSONType)
                }
            }
        }.resume()
    }
}

private typealias Helpers = HTTPClient
