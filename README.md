# CleanNetwork

![swift package manager](https://img.shields.io/badge/swift%20package%20manager-compatible-brightgreen)
![swift](https://img.shields.io/badge/swift-5.5-orange?logo=swift)
![platforms](https://img.shields.io/badge/platforms-macOS--10.15_iOS--13_tvOS--13_watchOS--6-yellowgreen)
![license](https://img.shields.io/badge/license-MIT-green)
![Twitter: @alperenunal68](https://img.shields.io/badge/twitter-@alperenunal68-blue.svg?style=flat)

`CleanNetwork` is a lightweight URLSession wrapper for using async/await in networking. You can use CleanNetwork for creating a modular network layer in projects. CleanNetwork is best way to combine asnc/await with networking. Feel free to contribute :)

# Table of contents

- [CleanNetwork](#cleannetwork)
- [Table of contents](#table-of-contents)
  - [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
  - [Simple Usage](#simple-usage)
    - [Creating CLEndpoint](#creating-clendpoint)
    - [Creating Request Object](#creating-request-object)
    - [Sending Request](#sending-request)
  - [Advance Usage](#advance-usage)
    - [Requests](#requests)
    - [Customize CLNetworkService](#customize-clnetworkservice)
      - [CLNetworkConfig](#clnetworkconfig)
    - [Error Handling](#error-handling)

## Installation
### Swift Package Manager

Once you have your Swift package set up, adding CleanNetwork as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/alperen23230/CleanNetwork", .upToNextMajor(from: "1.0.0"))
]
```

## Simple Usage
Firstly you have to create a request object for sending request. You can use `CLNetworkDecodableRequest` type for this.

```swift
struct ExampleRequest: CLNetworkDecodableRequest {
    typealias ResponseType = ExampleDecodableModel

    let endpoint: CLEndpoint
    let method: CLHTTPMethod
    
    init(endpoint: CLEndpoint, method: CLHTTPMethod) {
        self.endpoint = endpoint
        self.method = method
    }
}
```
### Creating CLEndpoint
CLEndpoint is a struct which represents an API endpoint. It has a baseURL, path and queryItems variables. For baseURL, there is a global variable for this. It's called `BASE_URL`. (For example you can set BASE_URL in AppDelegate) For url scheme, it uses `https` by default but you can change using `URL_SCHEME` global variable.

```swift
public struct CLEndpoint {
    public var baseURL: String
    public var path: String
    public var queryItems: [URLQueryItem]
    
    public init(baseURL: String = BASE_URL, path: String, queryItems: [URLQueryItem] = []) {
        self.baseURL = baseURL
        self.path = path
        self.queryItems = queryItems
    }
}
```

### Creating Request Object
```swift
let endpoint = CLEndpoint(path: "/example")
let method: CLHTTPMethod = .get
let exampleRequest = ExampleRequest(endpoint: endpoint, method: method) 
```

### Sending Request
You have to use `CLNetworkService` for sending request. You can use both shared object or creating object. Use `fetch` method of network service object.

```swift
do {
    let response = try await CLNetworkService.shared.fetch(exampleRequest)
    await MainActor.run {
        // Switch to main thread
    }
} catch {
    // Handle error here
}
```

## Advance Usage
### Requests
There are 3 request protocol. 

`CLNetworkRequest` is the basic protocol. It's for fetching raw `Data`. By default `method` is GET and `headers` are empty.

```swift
public protocol CLNetworkRequest {
    var endpoint: CLEndpoint { get }
    var method: CLHTTPMethod { get }
    var headers: [String: String] { get }
}
```

`CLNetworkDecodableRequest` is for fetching decodable response. You have to specify response type in your request. It has to be `Decodable`.

```swift
public protocol CLNetworkDecodableRequest: CLNetworkRequest {
    associatedtype ResponseType: Decodable
    
    var endpoint: CLEndpoint { get }
    var method: CLHTTPMethod { get }
    var headers: [String: String] { get }
}
```

`CLNetworkBodyRequest` is for sending body request. You have to specify body type in your request. It has to be `Encodable`. By default `method` is POST.

```swift
public protocol CLNetworkBodyRequest: CLNetworkDecodableRequest {
    associatedtype RequestBodyType: Encodable
    
    var requestBody: RequestBodyType { get }
}
```
### Customize CLNetworkService

When you want to customize the `CLNetworkService` you have to use the `CLNetworkConfig` model. CLNetworkService takes this object in its initializer. By default it uses shared object of `CLNetworkConfig`.

```swift
public init(config: CLNetworkConfig = CLNetworkConfig.shared) {
    self.config = config
}
```

#### CLNetworkConfig
You can use both shared object or creating instance yourself. 

```swift
public class CLNetworkConfig {
    public static let shared = CLNetworkConfig()

    public var decoder = JSONDecoder()
    public var encoder = JSONEncoder()
    public var urlSession = URLSession.shared
    public var loggerEnabled = true
    public var sharedHeaders: [String: String] = [:]

    public init() {}
}
```

### Error Handling
There is an error enum for unique errors. It's called `CLError`. 

```swift
public enum CLError: Error {
    case errorMessage(CLErrorMessage)
    /// APIError response data, HTTP status code
    case apiError(Data, Int?)
}
```
The enum has a 2 case. The first case, `errorMessage` case is for handling known errors. (For example data returning nil.)

The second case, `apiError` case is for handling API error json models. This case is an associated value case. It's returning the data which will decode. Also returns the HTTP status code to handle some situations.
