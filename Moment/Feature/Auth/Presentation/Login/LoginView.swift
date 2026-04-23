//
//  LoginView.swift
//  Moment
//
//  登录页面
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
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
        HStack {
            HStack(spacing: Spacing.unit) {
                Image(systemName: "book.closed.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(Color.themeSurfaceTint)

                Text("Life Archive")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.themeOnSurface)
                    .tracking(-0.45)
            }

            Spacer()

            Button(action: viewModel.navigateToRegister) {
                Text("Get Started")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.themePrimary)
            }
        }
        .padding(.horizontal, Spacing.containerMargin)
    }

    // MARK: - 主内容

    private var mainContent: some View {
        VStack(spacing: Spacing.stackMedium) {
            Text("Welcome back")
                .font(.themeHeadlineMedium)
                .foregroundStyle(Color.themeOnSurface)

            loginForm
        }
    }

    // MARK: - 登录表单

    private var loginForm: some View {
        VStack(spacing: Spacing.stackMedium) {
            VStack(spacing: 20) {
                AuthEmailField(
                    placeholder: viewModel.identifierPlaceholder,
                    text: $viewModel.identifier
                )

                AuthTextField(
                    placeholder: "Password",
                    text: $viewModel.password,
                    isSecure: true,
                    isPasswordVisible: viewModel.isPasswordVisible,
                    onTogglePasswordVisibility: viewModel.togglePasswordVisibility
                )
            }

            HStack {
                Spacer()
                Button(action: viewModel.navigateToForgotPassword) {
                    Text("Forgot?")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.themePrimary)
                }
            }

            Button(action: viewModel.login) {
                Text("Sign In")
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
            .disabled(!viewModel.isFormValid)
            .opacity(viewModel.isFormValid ? 1 : 0.6)

            AuthDivider()

            SocialLoginButtons(
                onAppleTap: viewModel.signInWithApple,
                onWeChatTap: viewModel.signInWithWeChat
            )

            registerLink
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: RoundedCorner.large)
                .fill(Color.themeSurfaceContainerLowest)
                .shadow(color: Color.themePrimary.opacity(0.08), radius: 30, x: 0, y: 10)
        )
    }

    // MARK: - 注册链接

    private var registerLink: some View {
        Button(action: viewModel.navigateToRegister) {
            HStack(spacing: 0) {
                Text("Don't have an archive yet? ")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.themeOnSurfaceVariant)

                Text("Sign Up")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.themePrimary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}