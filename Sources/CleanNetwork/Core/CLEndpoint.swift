//
//  CLEndpoint.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

import Foundation

public struct CLEndpoint {
    var baseURL: String?
    var path: String
    var queryItems: [URLQueryItem] = []
}

// MARK: - URL
public extension CLEndpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        
        return url
    }
}
