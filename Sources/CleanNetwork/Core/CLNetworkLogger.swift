//
//  CLNetworkLogger.swift
//  
//
//  Created by Alperen Ünal on 8.07.2022.
//

import Foundation

struct CLNetworkLogger {
    static func log(request: URLRequest) {
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAsString)
        let method = request.httpMethod ?? ""
        let path = urlComponents?.path ?? ""
        let query = urlComponents?.query ?? ""
        let host = urlComponents?.host ?? ""
        
        var output = """
           URL: \(urlAsString) \n\n
           METHOD: \(method) PATH: \(path)?\(query) HTTP/1.1 \n
           HOST: \(host)\n
           """
        if let httpHeaders = request.allHTTPHeaderFields, !httpHeaders.isEmpty {
            output += "HTTP Headers: \n"
            for (key,value) in httpHeaders {
                output += "\(key): \(value) \n"
            }
            output += "HTTP Headers End \n"
        }
        
        if let body = request.httpBody {
            output += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }
        print(output)
    }
    
    static func log(data: Data?, response: HTTPURLResponse?, error: Error?) {
        print("\n - - - - - - - - - - INCOMMING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        let path = components?.path ?? ""
        let query = components?.query ?? ""
        
        var output = ""
        if let urlString = urlString {
            output += "URL: \(urlString)"
            output += "\n\n"
        }
        if let statusCode = response?.statusCode {
            output += "HTTP \(statusCode) PATH: \(path)?\(query)\n"
        }
        if let host = components?.host {
            output += "Host: \(host)\n"
        }
        if let httpHeaders = response?.allHeaderFields, !httpHeaders.isEmpty {
            output += "HTTP Headers: \n"
            for (key,value) in httpHeaders {
                output += "\(key): \(value) \n"
            }
            output += "HTTP Headers End \n"
        }
        if let body = data {
            output += "\n\(String(data: body, encoding: .utf8) ?? "")\n"
        }
        if error != nil {
            output += "\nError: \(error!.localizedDescription)\n"
        }
        print(output)
    }
    
    static func logDecodingError(with error: DecodingError) {
        print("\n\nDecoding Error\n")
        switch error {
        case .typeMismatch(let type, let context):
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        case .valueNotFound(let value, let context):
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        case .keyNotFound(let key, let context):
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        case .dataCorrupted(let context):
            print(context)
        @unknown default:
            print("Unknown decoding error")
        }
    }
}
