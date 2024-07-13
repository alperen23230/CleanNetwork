//
//  CLNetworkBodyRequest.swift
//  
//
//  Created by Alperen Ünal on 3.07.2022.
//

import Foundation

public protocol CLNetworkBodyRequest: CLNetworkDecodableRequest {
    associatedtype RequestBodyType: Encodable
    
    var requestBody: RequestBodyType { get }
    
    func build(encoder: JSONEncoder, with sharedHeaders: [String: String]) throws -> URLRequest
}

public extension CLNetworkBodyRequest {
    var method: CLHTTPMethod { .post }
}

public extension CLNetworkBodyRequest {
    func build(encoder: JSONEncoder, with sharedHeaders: [String: String]) throws -> URLRequest {
        var urlRequest = build(with: sharedHeaders)
        urlRequest.httpBody = try encoder.encode(requestBody)
        
        return urlRequest
    }
}
