//
//  CLNetworkService.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

import Foundation

public struct CLNetworkService: NetworkService {
    public static var shared = CLNetworkService()
    
    public var config: NetworkConfig = CLNetworkConfig()
    private let successRange = Set(200...299)
    
    private init() {}
    
    public func fetch<T: CLNetworkBodyRequest>(_ request: T) async throws -> T.ResponseType {
        let urlRequest = try request.build(encoder: config.encoder, with: config.sharedHeaders)
        return try await fetch(urlRequest: urlRequest)
    }
    
    public func fetch<T: CLNetworkDecodableRequest>(_ request: T) async throws -> T.ResponseType {
        return try await fetch(urlRequest: request.build(with: config.sharedHeaders))
    }
    
    public func fetch<T: CLNetworkRequest>(_ request: T) async throws -> Data {
        return try await fetch(urlRequest: request.build(with: config.sharedHeaders))
    }
    
    func fetch<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        let data = try await fetch(urlRequest: urlRequest)
        
        do {
            return try config.decoder.decode(T.self, from: data)
        } catch {
            if config.loggerEnabled, let error = error as? DecodingError {
                CLNetworkLogger.logDecodingError(with: error)
            }
            
            throw error
        }
    }
    
    func fetch(urlRequest: URLRequest) async throws -> Data {
        CLNetworkLogger.log(request: urlRequest)
        
        do {
            let (data, response) = try await config.urlSession.data(for: urlRequest)
            
            if let urlResponse = response as? HTTPURLResponse {
                CLNetworkLogger.log(data: data, response: urlResponse)
            }
            
            guard let urlResponse = response as? HTTPURLResponse,
                  successRange.contains(urlResponse.statusCode) else {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    throw CLError.apiError(data, statusCode)
                } else {
                    throw CLError.errorMessage(.statusCodeIsNotValid)
                }
            }
            
            return data
        } catch {
            CLNetworkLogger.logError(with: error)
            throw error
        }
    }
}
