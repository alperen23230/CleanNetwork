//
//  CLNetworkService.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

import Foundation

public class CLNetworkService: NetworkService {
    
    var config: CLNetworkConfig
    
    public init(config: CLNetworkConfig = CLNetworkConfig.shared) {
        self.config = config
    }
    
    public func fetch<T: CLNetworkBodyRequest>(_ request: T) async throws -> T.ResponseType {
        var urlRequest = URLRequest(url: request.endpoint.url)
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpMethod = request.method.rawValue
        let requestBody = try config.encoder.encode(request.requestBody)
        urlRequest.httpBody = requestBody
        return try await fetch(urlRequest: urlRequest)
    }
    
    public func fetch<T: CLNetworkRequest>(_ request: T) async throws -> T.ResponseType {
        var urlRequest = URLRequest(url: request.endpoint.url)
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpMethod = request.method.rawValue
        return try await fetch(urlRequest: urlRequest)
    }
    
    func fetch<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        let data: T = try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self = self else { return }
            self.config.urlSession.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    guard let data = data else {
                        continuation.resume(throwing: CLError.errorMessage("Error: Data is nil"))
                        return
                    }
                    do {
                        guard let urlResponse = response as? HTTPURLResponse,
                              (200...299).contains(urlResponse.statusCode) else {
                            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                                continuation.resume(throwing: CLError.apiError(data, statusCode))
                            } else {
                                continuation.resume(throwing: CLError.errorMessage("Error: Status code is not valid"))
                            }
                            return
                        }
                        let decodedData = try self.config.decoder.decode(T.self, from: data)
                        continuation.resume(returning: decodedData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
            .resume()
        }
        return data
    }
}
