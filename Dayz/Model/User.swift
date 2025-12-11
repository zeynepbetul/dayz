//
//  User.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 11.12.2025.
//

import Foundation

struct User: Codable {
    var id: String
    var username: String
    var email: String
    var name: String?
    var bio: String?
    var avatarUrl: String?
    var followers: Int
    var following: Int
    var createdAt: Date
}

struct PublicUser: Codable {
    var id: String
    var username: String
    var name: String?
    var bio: String?
    var avatarUrl: String?
    var followers: Int
    var following: Int
}

struct PrivateUser: Codable {
    var id: String
    var email: String
    var createdAt: Date
}
