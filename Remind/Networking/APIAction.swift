//
//  APIAction.swift
//  RickAndMorty
//
//  Created by Hrayr Yeghiazaryan on 25.03.2020.
//  Copyright © 2020 Hrayr Yeghiazaryan. All rights reserved.
//

import UIKit
import Alamofire

protocol APIAction: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var bodyParameters: [String: Any] { get }
    static var baseURL: String { get }
    var authHeader: [String: String] { get }
    var encoding: ParameterEncoding { get }
}

extension APIAction {
    func asURLRequest() throws -> URLRequest {
        var originalRequest = try URLRequest(url: Self.baseURL.appending(path),
                                             method: method,
                                             headers: authHeader)
        var params: [String: Any]?
        if !bodyParameters.isEmpty {
            params = nil
            do {
                let json = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
                originalRequest.httpBody = json
            } catch {
                print("Bad request")
            }
        }
        let encodedRequest = try encoding.encode(originalRequest, with: params)
        return encodedRequest
    }
}
