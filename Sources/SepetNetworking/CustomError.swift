//
//  CustomErrors.swift
//  
//
//  Created by Berkay Dişli on 27.11.2023.
//

import Foundation

public enum SepetErrors: LocalizedError  {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case failedToSignIn
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("The response from the server was invalid.", comment: "Invalid Response")
        case .invalidURL:
            return NSLocalizedString("The URL provided was invalid.", comment: "Invalid URL")
        case .invalidData:
            return NSLocalizedString("The data received from the server was invalid.", comment: "Invalid Data")
        case .network(let error):
            return error?.localizedDescription ?? NSLocalizedString("There was a network error.", comment: "Network Error")
        case .failedToSignIn:
            return NSLocalizedString("Failed to sign in with the provided credentials.", comment: "Failed To Sign In")
        }
    }
}
