//
//  File.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

import Foundation

protocol NetworkService {
    var decoder: JSONDecoder { get }
    
    func fetch<T: CLNetworkRequest>(_ request: T) async throws -> T.ResponseType
}
