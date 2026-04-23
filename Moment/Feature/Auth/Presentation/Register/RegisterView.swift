//
//  RegisterView.swift
//  Moment
//
//  注册页面
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            Color.themeBackground
                .ignoresSafeArea()

            AuthDecorations()

            ScrollView {
                VStack(spacing: 0) {
                    headerSection
                        .padding(.top, Spacing.containerMargin)

                    Spacer()
                        .frame(height: 53)

                    mainContent
                        .padding(.horizontal, Spacing.containerMargin)

                    Spacer()

                    AuthFooter()
                        .padding(.bottom, Spacing.stackLarge)
                }
                .frame(minHeight: UIScreen.main.bounds.height)
            }

            if viewModel.isLoading {
                AuthLoadingOverlay()
            }
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "An error occurred")
        }
        .onAppear {
            viewModel.authViewModel = authViewModel
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        AuthLogoHeader(showBackButton: true, onBackTap: viewModel.navigateToLogin)
            .padding(.horizontal, Spacing.containerMargin)
    }

    // MARK: - 主内容

    private var mainContent: some View {
        VStack(spacing: Spacing.stackMedium) {
            Text("Create Account")
                .font(.themeHeadlineMedium)
                .foregroundStyle(Color.themeOnSurface)

            registerForm
        }
    }

    // MARK: - 注册表单

    private var registerForm: some View {
        VStack(spacing: Spacing.stackMedium) {
            VStack(spacing: 20) {
                AuthEmailField(
                    placeholder: "Email",
                    text: $viewModel.email
                )

                AuthTextField(
                    placeholder: "Password",
                    text: $viewModel.password,
                    isSecure: true,
                    isPasswordVisible: viewModel.isPasswordVisible,
                    onTogglePasswordVisibility: viewModel.togglePasswordVisibility
                )

                AuthTextField(
                    placeholder: "Confirm Password",
                    text: $viewModel.confirmPassword,
                    isSecure: true,
                    isPasswordVisible: viewModel.isPasswordVisible,
                    onTogglePasswordVisibility: viewModel.togglePasswordVisibility
                )
            }

            passwordStrengthIndicator

            Button(action: viewModel.register) {
                Text("Sign Up")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.themeOnPrimaryContainer)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: RoundedCorner.default)
                            .fill(Color.themePrimary)
                            .shadow(color: Color.themePrimary.opacity(0.25), radius: 6, x: 0, y: 6)
                    )
            }
            .disabled(!viewModel.isFormValid || !viewModel.isPasswordMatching)
            .opacity(viewModel.isFormValid && viewModel.isPasswordMatching ? 1 : 0.6)

            AuthDivider()

            SocialLoginButtons(
                onAppleTap: viewModel.signInWithApple,
                onWeChatTap: viewModel.signInWithWeChat
            )

            loginLink
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: RoundedCorner.large)
                .fill(Color.themeSurfaceContainerLowest)
                .shadow(color: Color.themePrimary.opacity(0.08), radius: 30, x: 0, y: 10)
        )
    }

    // MARK: - 密码强度指示器

    private var passwordStrengthIndicator: some View {
        HStack(spacing: 4) {
            ForEach(PasswordStrength.allCases, id: \.self) { strength in
                Rectangle()
                    .fill(strengthColor(for: strength))
                    .frame(height: 4)
                    .clipShape(Capsule())
            }

            Text(viewModel.passwordStrength.label)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(viewModel.passwordStrength.color)
        }
        .opacity(viewModel.password.isEmpty ? 0 : 1)
        .animation(.easeInOut(duration: 0.2), value: viewModel.password)
    }

    private func strengthColor(for strength: PasswordStrength) -> Color {
        if viewModel.password.isEmpty {
            return Color.themeSurfaceVariant
        }

        let strengthOrder = [PasswordStrength.weak, .medium, .strong]
        guard let currentIndex = strengthOrder.firstIndex(of: viewModel.passwordStrength),
              let strengthIndex = strengthOrder.firstIndex(of: strength) else {
            return Color.themeSurfaceVariant
        }

        return strengthIndex <= currentIndex ? viewModel.passwordStrength.color : Color.themeSurfaceVariant
    }

    // MARK: - 登录链接

    private var loginLink: some View {
        Button(action: viewModel.navigateToLogin) {
            HStack(spacing: 0) {
                Text("Already have an account? ")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.themeOnSurfaceVariant)

                Text("Sign In")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.themePrimary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        RegisterView()
            .environmentObject(AuthViewModel())
    }
}