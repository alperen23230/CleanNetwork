//
//  CLNetworkConfig.swift
//  
//
//  Created by Alperen Ünal on 29.05.2022.
//

import Foundation

public protocol NetworkConfig {
    var decoder: JSONDecoder { get set }
    var encoder: JSONEncoder { get set }
    var urlSession: URLSession { get set }
    var loggerEnabled: Bool { get set }
    var sharedHeaders: [String: String] { get set }
}

public class CLNetworkConfig: NetworkConfig {
    public var decoder = JSONDecoder()
    public var encoder = JSONEncoder()
    public var urlSession = URLSession.shared
    public var loggerEnabled = true
    public var sharedHeaders: [String: String] = [:]

    public init() {}
}
