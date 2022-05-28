//
//  CLNetworkService.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

import Foundation

public class CLNetworkService: NetworkService {

    let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    public func fetch<T: CLNetworkRequest>(_ request: T) async throws -> T.ResponseType {
        var urlRequest = URLRequest(url: request.endpoint.url)
        urlRequest.httpMethod = request.method.rawValue
        
        let data: T.ResponseType = try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self = self else { return }
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    guard let data = data else {
                        // Throw data nil error
                        return
                    }
                    do {
                        guard let urlResponse = response as? HTTPURLResponse,
                              (200...299).contains(urlResponse.statusCode) else {
                            let decodedErrorResponse = try self.decoder.decode(T.APIErrorType.self, from: data)
                                  continuation.resume(throwing: decodedErrorResponse)
                                  return
                              }
                        let decodedData = try self.decoder.decode(T.ResponseType.self, from: data)
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
