//
//  RootView.swift
//  Moment
//
//  根视图 - 根据认证状态显示不同内容
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        Group {
            if !authViewModel.hasCompletedOnboarding {
                OnboardingView()
            } else if authViewModel.isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            authViewModel.checkAuthState()
        }
    }
}