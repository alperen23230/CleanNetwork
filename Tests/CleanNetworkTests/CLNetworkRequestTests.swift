//
//  CLNetworkRequestTests.swift
//  
//
//  Created by Alperen Ünal on 29.05.2022.
//

import XCTest
import CleanNetwork

class CLNetworkRequestTests: XCTestCase {
    
    override func setUp() async throws {
        try await super.setUp()
    }
    
    override func tearDown() async throws {
        CLURLComponent.baseURL = ""
        try await super.tearDown()
    }
    
    func test_post_request() throws {
        let endpoint = CLEndpoint(path: "/mockPost")
        let method: CLHTTPMethod = .post
        let requestBody = MockRequestBodyModel()
        let mockRequest = MockBodyRequest(endpoint: endpoint, method: method, requestBody: requestBody)
        
        XCTAssertEqual(mockRequest.endpoint, endpoint)
        XCTAssertEqual(mockRequest.method, method)
        XCTAssertEqual(mockRequest.requestBody, requestBody)
    }
    
    func test_request() throws {
        let endpoint = CLEndpoint(path: "/mock")
        let method: CLHTTPMethod = .get
        let mockRequest = MockRequest(endpoint: endpoint, method: method)
        
        XCTAssertEqual(mockRequest.endpoint, endpoint)
        XCTAssertEqual(mockRequest.method, method)
    }
    
    func test_request_with_different_baseURL() throws {
        CLURLComponent.baseURL = "mockAPI.com"
        let differentBaseURL = "mockAPI2.com"
        let endpoint = CLEndpoint(baseURL: differentBaseURL, path: "/mock")
        let method: CLHTTPMethod = .get
        let mockRequest = MockRequest(endpoint: endpoint, method: method)
        
        XCTAssertEqual(mockRequest.endpoint, endpoint)
    }
}
