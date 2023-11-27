//
//  File.swift
//  
//
//  Created by Berkay Dişli on 27.11.2023.
//

import Foundation

public typealias SepetHTTPHeaders = [String: String]

public enum SepetHTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

public enum SepetParametersEncoding {
    case url
    case body
}

public protocol SepetEndPoint {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: SepetHTTPMethods { get }
    var headers: SepetHTTPHeaders? { get set }
    var parameters: [String: String]? { get set }
    var parametersEncoding: SepetParametersEncoding? { get set }
}

public struct GenericEndPoint: SepetEndPoint {
    public var path: String
    public var baseURL: String
    public var method: SepetHTTPMethods
    public var headers: SepetHTTPHeaders?
    public var parameters: [String: String]?
    public var parametersEncoding: SepetParametersEncoding?

    public var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }

    public init(path: String, baseURL: String, method: SepetHTTPMethods, headers: SepetHTTPHeaders?, parameters: [String: String]?, parametersEncoding: SepetParametersEncoding?) {
        self.path = path
        self.baseURL = baseURL
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.parametersEncoding = parametersEncoding
    }
}

