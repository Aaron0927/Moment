//
//  SettingsUser.swift
//  Moment
//
//  设置页面用户实体
//

import Foundation

/// 设置页面用户信息
struct SettingsUser: Equatable {
    let id: String
    let displayName: String
    let avatarURL: URL?

    init(id: String, displayName: String, avatarURL: URL? = nil) {
        self.id = id
        self.displayName = displayName
        self.avatarURL = avatarURL
    }

    init(from user: User) {
        self.id = user.id
        self.displayName = user.displayName ?? "用户"
        self.avatarURL = user.avatarURL
    }
}
