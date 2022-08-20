//
//  CLNetworkRequest.swift
//  
//
//  Created by Alperen Ünal on 7.08.2022.
//

public protocol CLNetworkRequest {
    var endpoint: CLEndpoint { get }
    var method: CLHTTPMethod { get }
    var headers: [String: String] { get }
}

public extension CLNetworkRequest {
    var method: CLHTTPMethod {
        return .get
    }
    
    var headers: [String: String] {
        return [:]
    }
}
