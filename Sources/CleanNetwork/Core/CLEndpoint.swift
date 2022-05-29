//
//  CLEndpoint.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

import Foundation

public var BASE_URL = ""
public var URL_SCHEME = "https"

public struct CLEndpoint {
    public var path: String
    public var queryItems: [URLQueryItem]
    
    public init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }
}

// MARK: - URL
public extension CLEndpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = URL_SCHEME
        components.host = BASE_URL
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

// MARK: - Equatable
extension CLEndpoint: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.url == rhs.url
    }
}
