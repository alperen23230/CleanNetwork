//
//  MockURLSessionProtocol.swift
//  
//
//  Created by Alperen Ünal on 2.10.2022.
//

import Foundation
import XCTest

class MockURLSessionProtocol: URLProtocol {
    static var loadingHandler: (() throws -> (HTTPURLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLSessionProtocol.loadingHandler
        else {
            XCTFail("Loading handler should be set.")
            return
        }
        
        do {
            let (response, data) = try handler()
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data {
                client?.urlProtocol(self, didLoad: data)
            }
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
