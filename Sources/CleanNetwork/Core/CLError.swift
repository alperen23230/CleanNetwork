//
//  CLError.swift
//  
//
//  Created by Alperen Ünal on 29.05.2022.
//

import Foundation

public enum CLError: Error {
    case errorMessage(String)
    /// APIError response data, HTTP status code
    case apiError(Data, Int?)
}
