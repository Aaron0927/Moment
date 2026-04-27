//
//  SettingsViewModel.swift
//  Moment
//
//  设置页面视图模型
//

import Foundation
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    // MARK: - 状态

    @Published private(set) var currentUser: SettingsUser?
    @Published private(set) var isLoggingOut: Bool = false
    @Published var showLogoutConfirmation: Bool = false
    @Published var errorMessage: String?

    // MARK: - 依赖

    private let repository: SettingsRepository
    private let authViewModel: AuthViewModel

    // MARK: - 初始化

    init(repository: SettingsRepository) {
        self.repository = repository
        self.authViewModel = AuthViewModel()
        loadCurrentUser()
    }

    /// 使用外部传入的 authViewModel（用于测试）
    init(repository: SettingsRepository, authViewModel: AuthViewModel) {
        self.repository = repository
        self.authViewModel = authViewModel
        loadCurrentUser()
    }

    // MARK: - 操作

    /// 加载当前用户
    func loadCurrentUser() {
        currentUser = repository.getCurrentUser()
    }

    /// 请求退出登录
    func requestLogout() {
        showLogoutConfirmation = true
    }

    /// 确认退出登录
    func confirmLogout() {
        Task {
            isLoggingOut = true
            do {
                try await repository.clearAuth()
                authViewModel.signOut()
            } catch {
                errorMessage = "退出登录失败: \(error.localizedDescription)"
            }
            isLoggingOut = false
        }
    }

    /// 取消退出
    func cancelLogout() {
        showLogoutConfirmation = false
    }

    /// 跳转到个人资料页面
    func navigateToProfile() {
        // TODO: 实现个人资料页面跳转
    }
}
