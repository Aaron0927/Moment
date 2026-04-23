//
//  AuthViewModel.swift
//  Moment
//
//  认证状态管理
//

import SwiftUI
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    // MARK: - 导航状态

    @Published var navigationPath: NavigationPath = NavigationPath()

    // MARK: - 认证状态

    @Published var isLoggedIn: Bool = false
    @Published var hasCompletedOnboarding: Bool = false

    // MARK: - 依赖

    private let repository: AuthRepository

    // MARK: - 初始化

    init(repository: AuthRepository = AuthRepositoryImpl()) {
        self.repository = repository
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        checkAuthState()
    }

    // MARK: - 状态检查

    func checkAuthState() {
        isLoggedIn = repository.getCurrentUser() != nil
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }

    // MARK: - 导航操作

    func navigateToRegister() {
        navigationPath.append(AuthNavigationDestination.register)
    }

    func navigateToForgotPassword() {
        navigationPath.append(AuthNavigationDestination.forgotPassword)
    }

    func navigateToLogin() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }

    func navigateToHome() {
        isLoggedIn = true
        navigationPath = NavigationPath()
    }

    func popToRoot() {
        navigationPath = NavigationPath()
    }

    func signOut() {
        Task {
            try? await repository.signOut()
            isLoggedIn = false
            navigationPath = NavigationPath()
        }
    }
}