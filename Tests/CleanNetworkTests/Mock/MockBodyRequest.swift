//
//  MockBodyRequest.swift
//  
//
//  Created by Alperen Ünal on 3.07.2022.
//

import CleanNetwork

struct MockRequestBodyModel: Encodable, Equatable {}
struct MockBodyRequestAPIResponse: Decodable {}

struct MockBodyRequest: CLNetworkBodyRequest {
    typealias ResponseType = MockBodyRequestAPIResponse
    
    let endpoint: CLEndpoint
    let method: CLHTTPMethod
    var requestBody: MockRequestBodyModel
    
    init(endpoint: CLEndpoint, method: CLHTTPMethod, requestBody: MockRequestBodyModel) {
        self.endpoint = endpoint
        self.method = method
        self.requestBody = requestBody
    }
}
