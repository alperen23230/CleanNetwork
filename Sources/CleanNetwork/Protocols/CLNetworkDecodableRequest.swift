//
//  CLNetworkDecodableRequest.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

import Foundation

public protocol CLNetworkDecodableRequest: CLNetworkRequest {
    associatedtype ResponseType: Decodable
    
    var endpoint: CLEndpoint { get }
    var method: CLHTTPMethod { get }
    var headers: [String: String] { get }
    
    func build(with sharedHeaders: [String: String]) -> URLRequest
}
