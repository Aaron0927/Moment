//
//  LoginViewModel.swift
//  Moment
//
//  登录页面 ViewModel
//

import SwiftUI
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    // MARK: - 输入状态

    @Published var identifier: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false

    // MARK: - UI 状态

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false

    // MARK: - 验证状态

    var isFormValid: Bool {
        !identifier.isEmpty && !password.isEmpty
    }

    var identifierPlaceholder: String {
        "Email or Phone Number"
    }

    // MARK: - 依赖

    private let loginUseCase: LoginUseCase

    // MARK: - 外部 ViewModel

    weak var authViewModel: AuthViewModel?

    // MARK: - 初始化

    init(loginUseCase: LoginUseCase = LoginUseCase(repository: AuthRepositoryImpl())) {
        self.loginUseCase = loginUseCase
    }

    // MARK: - 操作

    func login() {
        guard isFormValid else {
            showError(message: "Please fill in all fields")
            return
        }

        isLoading = true
        errorMessage = nil

        let credentials = AuthCredentials(identifier: identifier, password: password)

        Task {
            do {
                let user = try await loginUseCase.execute(credentials: credentials)
                isLoading = false
                // 登录成功，跳转到首页
                authViewModel?.navigateToHome()
            } catch let error as AuthError {
                isLoading = false
                showError(message: error.errorDescription ?? "Login failed")
            } catch {
                isLoading = false
                showError(message: "An unexpected error occurred")
            }
        }
    }

    func signInWithApple() {
        // TODO: Implement Apple Sign In
    }

    func signInWithWeChat() {
        // TODO: Implement WeChat Sign In
    }

    func navigateToRegister() {
        authViewModel?.navigateToRegister()
    }

    func navigateToForgotPassword() {
        authViewModel?.navigateToForgotPassword()
    }

    func togglePasswordVisibility() {
        isPasswordVisible.toggle()
    }

    private func showError(message: String) {
        errorMessage = message
        showError = true
    }
}
