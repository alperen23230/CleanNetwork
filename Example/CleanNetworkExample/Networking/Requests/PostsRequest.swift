//
//  PostsRequest.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 11.06.2022.
//

import CleanNetwork

struct PostsRequest: CLNetworkDecodableRequest {
    typealias ResponseType = [Post]
    
    let endpoint: CLEndpoint = CLEndpoint(path: "posts")
    let method: CLHTTPMethod = .get
    
    init() {}
}
