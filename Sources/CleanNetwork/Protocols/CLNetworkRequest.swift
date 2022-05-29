//
//  CLNetworkRequest.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

public struct CLAPIError: Decodable, Error {}

public protocol CLNetworkRequest {
    associatedtype ResponseType: Decodable
    associatedtype APIErrorType: Decodable & Error
    
    var endpoint: CLEndpoint { get }
    var method: CLHTTPMethod { get }
}

public extension CLNetworkRequest {
    typealias APIErrorType = CLAPIError
    
    var method: CLHTTPMethod {
        return .get
    }
}
