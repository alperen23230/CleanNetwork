//
//  NetworkService.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

import Foundation

protocol NetworkService {
    var config: CLNetworkConfig { get }
    
    func fetch<T: CLNetworkBodyRequest>(_ request: T) async throws -> T.ResponseType
    func fetch<T: CLNetworkDecodableRequest>(_ request: T) async throws -> T.ResponseType
    func fetch<T: CLNetworkRequest>(_ request: T) async throws -> Data
    func fetch<T: Decodable>(urlRequest: URLRequest) async throws -> T
    func fetchData(urlRequest: URLRequest) async throws -> Data
}
