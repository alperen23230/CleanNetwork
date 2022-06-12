//
//  Post.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 11.06.2022.
//

struct Post: Decodable, Identifiable {
    let id: Int
    let title: String
    let body: String
}
