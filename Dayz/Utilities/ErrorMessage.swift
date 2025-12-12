//
//  ErrorMessage.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 12.12.2025.
//

import Foundation

enum DZError: String, Error {
    case usernameTaken = "This username is already taken."
    case networkError = "A network error occurred."
    case emailVerificationError = "Error in sending verification email."
    case unknownError = "An unknown error occured."
    case userCreateError = "Error occured in creating user."
    case loadUsersError = "Error in loading users"
}
