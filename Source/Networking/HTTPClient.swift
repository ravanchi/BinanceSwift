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
    func execute(type: RequestType, endpoint: Endpoint, params: [String: String]?, success: @escaping HTTPClientSuccessCompletion, failed: @escaping HTTPClientFailedCompletion)
}

/**
 Binance specific HTTPClient that communicates with the Binance REST API.
 This is intended to be an internal class that the BinanceClient utilizes. Please look at the BinanceClient to see if a convenience interface has been made for the endpoint you want to interact with.
 */
class HTTPClient: HTTPClientInterface {
    static let sharedInstance = HTTPClient()

    func execute(type: RequestType, endpoint: Endpoint, params: [String: String]?, success: @escaping HTTPClientSuccessCompletion, failed: @escaping HTTPClientFailedCompletion) {
        var queryParams = params ?? [:]

        var requestString = APIConstants.baseURL + endpoint.rawValue

        if endpoint.isSigned() {
            queryParams["timestamp"] = String(Date().timeIntervalSince1970)

            if let secret = queryParams[APIConstants.secret] {
                let tempRequestString = requestString + "?" + generateParamsString(params: queryParams)
                queryParams[APIConstants.signature] = tempRequestString.hmac(algorithm: .SHA256, key: secret)
            } else {
                failed(.invalidKeys)
            }
        }


        requestString.append("?" + generateParamsString(params: queryParams))

        var request = URLRequest(url: NSURL(string: requestString)! as URL)
        request.httpMethod = type.rawValue

        if type == .post {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            if let apiKey = queryParams[APIConstants.apiKey], endpoint.isSigned() {
                request.setValue(apiKey, forHTTPHeaderField: APIConstants.headerApiKey)
            }
        }

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

    func generateParamsString(params: [String: String]) -> String {
        var generatedString = ""

        // filter out the apikey and secret if present
        let filteredParams = params.filter({$0.key != APIConstants.apiKey && $0.key != APIConstants.secret})

        for key in filteredParams.keys {
            if let paramsValue = filteredParams[key] {
                generatedString.append(key + "=" + paramsValue)
            }
        }

        return generatedString
    }
}

private typealias Helpers = HTTPClient
