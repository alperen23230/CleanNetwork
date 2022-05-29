//
//  CLNetworkRequestTests.swift
//  
//
//  Created by Alperen Ünal on 29.05.2022.
//

import XCTest
import CleanNetwork

class CLNetworkRequestTests: XCTestCase {
    func testRequest() throws {
        let endpoint = CLEndpoint(path: "/mock")
        let method: CLHTTPMethod = .get
        let mockRequest = MockRequest(endpoint: endpoint, method: method)
        
        XCTAssertEqual(mockRequest.endpoint, endpoint)
        XCTAssertEqual(mockRequest.method, method)
    }
}
