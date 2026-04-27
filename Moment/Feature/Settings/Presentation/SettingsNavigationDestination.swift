//
//  SettingsNavigationDestination.swift
//  Moment
//
//  设置页面导航目标
//

import Foundation

/// 设置页面导航目标 - 每次导航使用唯一 ID 确保视图重新创建
struct SettingsNavigationDestination: Hashable {
    let id = UUID()

    static func == (lhs: SettingsNavigationDestination, rhs: SettingsNavigationDestination) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
