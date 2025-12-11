//
//  User.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 11.12.2025.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var bio: String?
    var publicCalendar: Bool
    var sharedCalendar: Bool
    var privateCalendar: Bool
    var following: Int
    var followers: Int
    var createdAt: String
}
