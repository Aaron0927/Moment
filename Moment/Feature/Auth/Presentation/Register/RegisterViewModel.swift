//
//  RegisterViewModel.swift
//  Moment
//
//  注册页面 ViewModel
//

import SwiftUI
import Combine

@MainActor
final class RegisterViewModel: ObservableObject {
    // MARK: - 输入状态

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isPasswordVisible: Bool = false

    // MARK: - UI 状态

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false

    // MARK: - 验证状态

    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }

    var isPasswordMatching: Bool {
        password == confirmPassword
    }

    var passwordStrength: PasswordStrength {
        PasswordStrength.evaluate(password)
    }

    // MARK: - 依赖

    private let registerUseCase: RegisterUseCase

    // MARK: - 外部 ViewModel

    weak var authViewModel: AuthViewModel?

    // MARK: - 初始化

    init(registerUseCase: RegisterUseCase = RegisterUseCase(repository: AuthRepositoryImpl())) {
        self.registerUseCase = registerUseCase
    }

    // MARK: - 操作

    func register() {
        guard isFormValid else {
            showError(message: "Please fill in all fields")
            return
        }

        guard isPasswordMatching else {
            showError(message: "Passwords do not match")
            return
        }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let user = try await registerUseCase.execute(email: email, password: password)
                isLoading = false
                // 注册成功，跳转到首页
                authViewModel?.navigateToHome()
            } catch let error as AuthError {
                isLoading = false
                showError(message: error.errorDescription ?? "Registration failed")
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

    func navigateToLogin() {
        authViewModel?.navigateToLogin()
    }

    func togglePasswordVisibility() {
        isPasswordVisible.toggle()
    }

    private func showError(message: String) {
        errorMessage = message
        showError = true
    }
}
