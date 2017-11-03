//
//  HTTPClient.swift
//  BinanceSwift
//
//  Created by Ali Ravanchi on 11/2/17.
//  Copyright © 2017 Cardinal Labs. All rights reserved.
//

import Foundation

typealias HTTPClientSuccessCompletion = (Any) -> Void
typealias HTTPClientFailedCompletion = (BinanceError) -> Void

private typealias dataTaskSuccessCompletion = (Any?) -> Void
private typealias dataTaskFailedCompletion = (BinanceError) -> Void

enum RequestType: String {
    case get
    case post
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
    func execute(type: RequestType, endpoint: Endpoint, params: [String: Any]?, success: @escaping HTTPClientSuccessCompletion, failed: @escaping HTTPClientFailedCompletion)
}

/**
 Binance specific HTTPClient that communicates with the Binance REST API.
 This is intended to be an internal class that the BinanceClient utilizes. Please look at the BinanceClient to see if a convenience interface has been made for the endpoint you want to interact with.
 */
class HTTPClient: HTTPClientInterface {
    static let sharedInstance = HTTPClient()

    func execute(type: RequestType, endpoint: Endpoint, params: [String: Any]?, success: @escaping HTTPClientSuccessCompletion, failed: @escaping HTTPClientFailedCompletion) {
        var requestString = APIConstants.baseURL + endpoint.rawValue
        if let params = params {
            requestString.append("?" + generateParamsString(params: params))
        }

        var request = URLRequest(url: NSURL(string: requestString)! as URL)
        request.httpMethod = type.rawValue

        dataTask(request: request, taskSuccess: { (json) in
            guard let json = json else {
                failed(BinanceError.failedResponse)
                return
            }

            success(json)
        }, taskFailed: { (error) in
            failed(error)
        })
    }
}

fileprivate extension Helpers {
    func dataTask(request: URLRequest, taskSuccess: @escaping dataTaskSuccessCompletion, taskFailed: @escaping dataTaskFailedCompletion) {
        let session = URLSession(configuration: URLSessionConfiguration.default)

        session.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    taskSuccess(json)
                } else {
                    // Either
                    // datask failed to reach server? no connection?
                    // datask reached the server, but request could be invalid or failed

                    // Reached the server, but got a failed status code
                    if json != nil {
                        taskFailed(BinanceError.failedResponse)
                    } else {
                        taskFailed(BinanceError.noResponse)
                    }
                }
            }
        }.resume()
    }

    func generateParamsString(params: [String: Any]) -> String {
        var generatedString = ""
        for key in params.keys {
            if let paramsValue = params[key] {
                generatedString.append(key + "=" + String(describing: paramsValue))
            }
        }

        return generatedString
    }
}

private typealias Helpers = HTTPClient
