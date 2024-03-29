//
//  CLNetworkBodyRequest.swift
//  
//
//  Created by Alperen Ünal on 3.07.2022.
//

public protocol CLNetworkBodyRequest: CLNetworkDecodableRequest {
    associatedtype RequestBodyType: Encodable
    
    var requestBody: RequestBodyType { get }
}

public extension CLNetworkBodyRequest {
    var method: CLHTTPMethod { .post }
}
