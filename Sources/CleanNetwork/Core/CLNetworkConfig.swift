//
//  CLNetworkConfig.swift
//  
//
//  Created by Alperen Ünal on 29.05.2022.
//

import Foundation

public class CLNetworkConfig {
    public static let shared = CLNetworkConfig()

    public var decoder = JSONDecoder()
    public var urlSession = URLSession.shared

    public init() {}
}
