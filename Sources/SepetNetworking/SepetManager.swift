//
//  SepetManager.swift
//  
//
//  Created by Berkay Dişli on 27.11.2023.
//

import Foundation

public typealias ResultCompletion<T> = (CustomResult<T>) -> Void
public typealias CustomResult<T> = Result<T?, SepetErrors>

public final class SepetManager {
    
    static let shared = SepetManager()
    
    public init() {}
    
    public static var sharedHeaders : SepetHTTPHeaders {
        ["Content-Type": "application/json"]
    }
    
    public func request<T: Codable>(endpoint: SepetEndPoint, completion: @escaping ResultCompletion<T>) {
        guard let _ = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
                
        var request = URLRequest(endpoint: endpoint)
        request.log()
        
        if endpoint.parametersEncoding == .body , let parameters = endpoint.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            data?.log()
            
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.network(error)))
            }
            
        }.resume()
    }
}

extension SepetManager {
    public func createEndpoint(path: String, baseURL: String, method: SepetHTTPMethods, headers: SepetHTTPHeaders? = nil, parameters: [String: String]? = nil, parametersEncoding: SepetParametersEncoding? = .url) -> SepetEndPoint {
        return GenericEndPoint(path: path, baseURL: baseURL, method: method, headers: headers, parameters: parameters, parametersEncoding: parametersEncoding)
    }
}

public extension URLRequest {
    init(endpoint: SepetEndPoint) {
        var component = URLComponents(string: endpoint.url!.absoluteString)!
        
        if let parameters = endpoint.parameters, let encoding = endpoint.parametersEncoding {
            if encoding == .url {
                component.queryItems = parameters.map { (key, value) in
                    URLQueryItem(name: key, value: value)
                }
            }
        }
        
        self.init(url: component.url!)
    }
    
    func log() {
        print("\(httpMethod ?? "") \(self)")
        if let allHTTPHeaderFields = allHTTPHeaderFields {
            print("HEADERS \n \(allHTTPHeaderFields)")
        }
        if let body = httpBody?.log() {
            print("BODY \n \(body)")
        }
    }
    
}

public extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
    
    func log() {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return }
        
        debugPrint(prettyPrintedString)
    }
}

