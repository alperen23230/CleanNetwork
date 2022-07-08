//
//  CreatePostRequest.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 3.07.2022.
//

import CleanNetwork

struct CreatePostRequest: CLNetworkBodyRequest {
    typealias ResponseType = Post
    
    let endpoint: CLEndpoint = CLEndpoint(path: "posts")
    let requestBody: CreatePostRequestBody
    
    init(requestBody: CreatePostRequestBody) {
        self.requestBody = requestBody
    }
}
