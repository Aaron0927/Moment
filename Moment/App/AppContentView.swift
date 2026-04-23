//
//  AppContentView.swift
//  Moment
//
//  应用内容视图 - NavigationStack 包装
//

import SwiftUI

struct AppContentView: View {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
        NavigationStack(path: $authViewModel.navigationPath) {
            RootView()
                .environmentObject(authViewModel)
                .navigationDestination(for: AuthNavigationDestination.self) { destination in
                    switch destination {
                    case .register:
                        RegisterView()
                    case .forgotPassword:
                        Text("Forgot Password")
                    }
                }
        }
    }
}

#Preview {
    AppContentView()
}