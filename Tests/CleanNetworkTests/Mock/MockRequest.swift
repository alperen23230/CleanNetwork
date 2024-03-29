//
//  MockRequest.swift
//  
//
//  Created by Alperen Ünal on 29.05.2022.
//

import CleanNetwork

struct MockAPIResponse: Decodable {}

struct MockRequest: CLNetworkDecodableRequest {
    typealias ResponseType = MockAPIResponse
    
    let endpoint: CLEndpoint
    let method: CLHTTPMethod
    
    init(endpoint: CLEndpoint, method: CLHTTPMethod) {
        self.endpoint = endpoint
        self.method = method
    }
}
