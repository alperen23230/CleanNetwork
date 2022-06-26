//
//  APIError.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 26.06.2022.
//

struct APIError: Decodable, Error {
    let errorMessage: String
}
