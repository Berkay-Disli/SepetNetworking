//
//  CustomErrors.swift
//  
//
//  Created by Berkay Dişli on 27.11.2023.
//

import Foundation

public enum CustomErrors: LocalizedError  {
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

public enum AuthErrors: LocalizedError {
    case emptyUsername
    case emptyEmail
    case invalidEmail
    case emptyPassword
    case shortPassword
    case shortUsername
    
    case userProfileNotFetched
    
    public var errorDescription: String? {
        switch self {
        case .emptyUsername:
            return NSLocalizedString("You should choose a username", comment: "Empty Username")
        case .shortUsername:
            return NSLocalizedString("Username is too short", comment: "Short Username")
        case .emptyEmail:
            return NSLocalizedString("Email can not be empty.", comment: "Empty Email")
        case .invalidEmail:
            return NSLocalizedString("Email is not valid.", comment: "Invalid Email")
        case .emptyPassword:
            return NSLocalizedString("Password can not be empty", comment: "Empty Password")
        case .shortPassword:
            return NSLocalizedString("Password is too short", comment: "Short Password")
        case .userProfileNotFetched:
            return NSLocalizedString("Could not fetch user profile", comment: "User Profile not Fetched")
        }
    }
}
