//
//  SettingsRepository.swift
//  Moment
//
//  设置仓库协议
//

import Foundation

/// 设置仓库协议
protocol SettingsRepository {
    /// 获取当前用户
    func getCurrentUser() -> SettingsUser?

    /// 清除认证信息（退出登录）
    func clearAuth() async throws
}
