//
//  CLNetworkRequest.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

public protocol CLNetworkRequest {
    associatedtype ResponseType: Decodable
    
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
