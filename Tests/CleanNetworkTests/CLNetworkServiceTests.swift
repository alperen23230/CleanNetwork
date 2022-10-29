//
//  CLNetworkServiceTests.swift
//  
//
//  Created by Alperen Ünal on 2.10.2022.
//

import XCTest
import CleanNetwork

final class CLNetworkServiceTests: XCTestCase {
    private var networkService: CLNetworkService!
    private var request: UsersMockRequest!

    override func setUpWithError() throws {
        try super.setUpWithError()
        CLURLComponent.baseURL = "mockAPI.com"
        let endpoint = CLEndpoint(path: "/mock")
        request = UsersMockRequest(endpoint: endpoint)
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLSessionProtocol.self]
        
        networkService = .shared
        networkService.config.loggerEnabled = false
        networkService.config.urlSession = URLSession(configuration: sessionConfiguration)
    }

    override func tearDownWithError() throws {
        CLURLComponent.baseURL = ""
        request = nil
        networkService = nil
        try super.tearDownWithError()
    }
    
    func test_when_came_valid_response_data() async throws {
        guard let path = Bundle.module.path(forResource: "UsersMock", ofType: "json"),
              let data = FileManager.default.contents(atPath: path)
        else {
            XCTFail("Failed to get mock json data.")
            return
        }
        
        let expectedData = try JSONDecoder().decode([UserMockModel].self, from: data)
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.request.endpoint.url, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)
            return (response!, data)
        }
        
        let usersResponseData = try await networkService.fetch(request)
        
        XCTAssertEqual(usersResponseData, expectedData)
    }
    
    func test_when_came_error_from_api() async {
        let expectedError = NSError(domain: "url not found", code: -1)
        
        MockURLSessionProtocol.loadingHandler = {
            throw expectedError
        }
        
        do {
            _ = try await networkService.fetch(request)
            XCTFail("This call should throw an error.")
        } catch let error as NSError {
            XCTAssertEqual(error.domain, expectedError.domain)
            XCTAssertEqual(error.code, expectedError.code)
        }
    }
}
