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
    /**
     Executes a HTTP call to the Binance API.

     - parameter type: The type of HTTP request (GET or POST)
     - parameter endpoint: The API endpoint being hit (i.e time, ping, depth, etc.)
     - parameter params: Addition parameters being sent to the Binance API
     - parameter success: Success callback with the json returned from the Binance API
     - parameter failed: Failed callback with error object highlighting what went wrong
     */
    func execute(type: RequestType, endpoint: Endpoint, params: JSONType?, success: @escaping HTTPClientSuccessCompletion, failed: @escaping HTTPClientFailedCompletion)
}

/**
 Binance specific HTTPClient that communicates with the Binance REST API.
 This is intended to be an internal class that the BinanceClient utilizes. Please look at the BinanceClient to see if a convenience interface has been made for the endpoint you want to interact with.
 */
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
