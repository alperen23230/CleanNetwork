//
//  CLNetworkRequest.swift
//  
//
//  Created by Alperen Ünal on 7.08.2022.
//

import Foundation

public protocol CLNetworkRequest {
    var endpoint: CLEndpoint { get }
    var method: CLHTTPMethod { get }
    var headers: [String: String] { get }
    
    func build(with sharedHeaders: [String: String]) -> URLRequest
}

public extension CLNetworkRequest {
    var method: CLHTTPMethod { .get }
    var headers: [String: String] { .init() }
}

public extension CLNetworkDecodableRequest {
    func build(with sharedHeaders: [String: String]) -> URLRequest {
        var urlRequest = URLRequest(url: endpoint.url)
        let allHeaders = sharedHeaders.merging(headers) { (_, new) in new }
        urlRequest.allHTTPHeaderFields = allHeaders
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
