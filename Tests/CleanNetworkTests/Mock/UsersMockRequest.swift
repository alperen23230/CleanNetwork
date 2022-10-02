//
//  UsersMockRequest.swift
//  
//
//  Created by Alperen Ünal on 2.10.2022.
//

import CleanNetwork

struct UsersMockRequest: CLNetworkDecodableRequest {
    typealias ResponseType = [UserMockModel]
    
    let endpoint: CLEndpoint
    let method: CLHTTPMethod = .get
    
    init(endpoint: CLEndpoint) {
        self.endpoint = endpoint
    }
}
