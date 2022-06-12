//
//  PostsRequest.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 11.06.2022.
//

import CleanNetwork

struct PostsRequest: CLNetworkRequest {
    
    typealias ResponseType = [Post]
    
    let endpoint: CLEndpoint
    let method: CLHTTPMethod = .get
    
    init() {
        endpoint = CLEndpoint(path: "posts")
    }
}
