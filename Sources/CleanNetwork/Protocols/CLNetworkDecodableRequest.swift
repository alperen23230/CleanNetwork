//
//  CLNetworkDecodableRequest.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

public protocol CLNetworkDecodableRequest: CLNetworkRequest {
    associatedtype ResponseType: Decodable
    
    var endpoint: CLEndpoint { get }
    var method: CLHTTPMethod { get }
    var headers: [String: String] { get }
}
