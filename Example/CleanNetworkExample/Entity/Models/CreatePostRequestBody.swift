//
//  CreatePostRequestBody.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 3.07.2022.
//

struct CreatePostRequestBody: Encodable {
    let userId: Int
    let title: String
    let body: String
}
