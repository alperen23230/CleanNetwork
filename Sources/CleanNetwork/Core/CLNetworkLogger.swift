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
           \(urlAsString) \n\n
           \(method) \(path)?\(query) HTTP/1.1 \n
           HOST: \(host)\n
           """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            output += "\(key): \(value) \n"
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
            output += "\(urlString)"
            output += "\n\n"
        }
        if let statusCode =  response?.statusCode {
            output += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host {
            output += "Host: \(host)\n"
        }
        for (key, value) in response?.allHeaderFields ?? [:] {
            output += "\(key): \(value)\n"
        }
        if let body = data {
            output += "\n\(String(data: body, encoding: .utf8) ?? "")\n"
        }
        if error != nil {
            output += "\nError: \(error!.localizedDescription)\n"
        }
        print(output)
    }
}
