//
//  CLHTTPMethod.swift
//  
//
//  Created by Alperen Ünal on 28.05.2022.
//

public enum CLHTTPMethod {
    case get
    case post
    case put
    case delete
    case patch
    
    public var rawValue: String {
        String(describing: self).uppercased()
    }
}
