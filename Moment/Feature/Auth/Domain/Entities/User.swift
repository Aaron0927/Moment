//
//  User.swift
//  Moment
//
//  用户实体
//

import Foundation

struct User: Identifiable, Equatable, Codable {
    let id: String
    let email: String?
    let phone: String?
    let displayName: String?
    let avatarURL: URL?

    var isEmailUser: Bool { email != nil }
    var isPhoneUser: Bool { phone != nil }
}
