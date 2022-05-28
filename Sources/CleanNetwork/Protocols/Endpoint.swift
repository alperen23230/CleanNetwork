//
//  Endpoint.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

import Foundation

public protocol Endpoint {
    var baseURL: String? { get set }
    var url: URL { get set }
    var path: String { get set }
    var queryItems: [URLQueryItem] { get set }
}
