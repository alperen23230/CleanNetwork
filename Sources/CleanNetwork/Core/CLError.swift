//
//  CLError.swift
//  
//
//  Created by Alperen Ünal on 29.05.2022.
//

import Foundation

public enum CLError: Error {
    
    /// Pre-defined error cases
    case errorMessage(CLErrorMessage)
   
    /// APIError response data, HTTP status code
    case apiError(Data, Int?)
}

// MARK: - CLErrorMessage

public enum CLErrorMessage: String {
    case dataIsNil = "Error: Data is nil"
    case statusCodeIsNotValid = "Error: Status code is not valid"
}
