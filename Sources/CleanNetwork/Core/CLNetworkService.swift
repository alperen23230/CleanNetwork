//
//  CLNetworkService.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

import Foundation

public struct CLNetworkService: NetworkService {
    
    public static let shared = CLNetworkService()
    var config: CLNetworkConfig = .shared
    
    private let successRange = Set(200...299)
    
    private init() {}
    
    public func fetch<T: CLNetworkBodyRequest>(_ request: T) async throws -> T.ResponseType {
        var urlRequest = URLRequest(url: request.endpoint.url)
        let allHeaders = config.sharedHeaders.merging(request.headers) { (_, new) in new }
        urlRequest.allHTTPHeaderFields = allHeaders
        urlRequest.httpMethod = request.method.rawValue
        let requestBody = try config.encoder.encode(request.requestBody)
        urlRequest.httpBody = requestBody
        return try await fetch(urlRequest: urlRequest)
    }
    
    public func fetch<T: CLNetworkDecodableRequest>(_ request: T) async throws -> T.ResponseType {
        var urlRequest = URLRequest(url: request.endpoint.url)
        let allHeaders = config.sharedHeaders.merging(request.headers) { (_, new) in new }
        urlRequest.allHTTPHeaderFields = allHeaders
        urlRequest.httpMethod = request.method.rawValue
        return try await fetch(urlRequest: urlRequest)
    }
    
    public func fetch<T: CLNetworkRequest>(_ request: T) async throws -> Data {
        var urlRequest = URLRequest(url: request.endpoint.url)
        let allHeaders = config.sharedHeaders.merging(request.headers) { (_, new) in new }
        urlRequest.allHTTPHeaderFields = allHeaders
        urlRequest.httpMethod = request.method.rawValue
        return try await fetchData(urlRequest: urlRequest)
    }
    
    func fetch<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        if config.loggerEnabled {
            CLNetworkLogger.log(request: urlRequest)
        }
        
        let data: T = try await withCheckedThrowingContinuation { continuation in
            self.config.urlSession.dataTask(with: urlRequest) { (data, response, error) in
                if config.loggerEnabled, let urlResponse = response as? HTTPURLResponse {
                    CLNetworkLogger.log(data: data, response: urlResponse, error: error)
                }
                
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    guard let data = data else {
                        continuation.resume(throwing: CLError.errorMessage(.dataIsNil))
                        return
                    }
                    do {
                        guard let urlResponse = response as? HTTPURLResponse,
                              successRange.contains(urlResponse.statusCode) else {
                            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                                continuation.resume(throwing: CLError.apiError(data, statusCode))
                            } else {
                                continuation.resume(throwing: CLError.errorMessage(.statusCodeIsNotValid))
                            }
                            return
                        }
                        let decodedData = try self.config.decoder.decode(T.self, from: data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        if config.loggerEnabled, let error = error as? DecodingError {
                            CLNetworkLogger.logDecodingError(with: error)
                        }
                        continuation.resume(throwing: error)
                    }
                }
            }
            .resume()
        }
        return data
    }
    
    func fetchData(urlRequest: URLRequest) async throws -> Data {
        if config.loggerEnabled {
            CLNetworkLogger.log(request: urlRequest)
        }
        
        let data: Data = try await withCheckedThrowingContinuation { continuation in
            self.config.urlSession.dataTask(with: urlRequest) { (data, response, error) in
                if config.loggerEnabled, let urlResponse = response as? HTTPURLResponse {
                    CLNetworkLogger.log(data: data, response: urlResponse, error: error)
                }
                
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    guard let data = data else {
                        continuation.resume(throwing: CLError.errorMessage(.dataIsNil))
                        return
                    }
                    guard let urlResponse = response as? HTTPURLResponse,
                          successRange.contains(urlResponse.statusCode) else {
                        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                            continuation.resume(throwing: CLError.apiError(data, statusCode))
                        } else {
                            continuation.resume(throwing: CLError.errorMessage(.statusCodeIsNotValid))
                        }
                        return
                    }
                    continuation.resume(returning: data)
                }
            }
            .resume()
        }
        return data
    }
}
