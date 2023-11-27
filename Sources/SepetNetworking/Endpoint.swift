//
//  File.swift
//  
//
//  Created by Berkay Dişli on 27.11.2023.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

public enum ParametersEncoding {
    case url
    case body
}

public protocol EndPoint {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String: String]? { get }
    var parametersEncoding: ParametersEncoding? { get }
}
