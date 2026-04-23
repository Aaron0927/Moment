//
//  AuthError.swift
//  Moment
//
//  认证错误
//

import Foundation

enum AuthError: LocalizedError, Equatable {
    case invalidIdentifier
    case invalidPassword
    case invalidEmail
    case weakPassword
    case userNotFound
    case wrongPassword
    case emailAlreadyInUse
    case networkError
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .invalidIdentifier:
            return "Please enter a valid email or phone number"
        case .invalidPassword:
            return "Please enter your password"
        case .invalidEmail:
            return "Please enter a valid email address"
        case .weakPassword:
            return "Password must be at least 8 characters"
        case .userNotFound:
            return "No account found with this email"
        case .wrongPassword:
            return "Incorrect password"
        case .emailAlreadyInUse:
            return "An account with this email already exists"
        case .networkError:
            return "Network error. Please check your connection"
        case .unknown(let message):
            return message
        }
    }
}
