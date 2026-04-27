//
//  RootView.swift
//  Moment
//
//  根视图 - 根据认证状态显示不同内容
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var selectedTab: Tab = .timeline

    enum Tab: String {
        case timeline, record, memories
    }

    var body: some View {
        Group {
            if !authViewModel.hasCompletedOnboarding {
                OnboardingView()
            } else if authViewModel.isLoggedIn {
                mainTabView
            } else {
                LoginView()
            }
        }
        .onAppear {
            authViewModel.checkAuthState()
        }
    }

    private var mainTabView: some View {
        TabView(selection: $selectedTab) {
            TimelineView()
                .tag(Tab.timeline)
                .tabItem {
                    Label("时间轴", systemImage: "clock.fill")
                }

            RecordView()
                .tag(Tab.record)
                .tabItem {
                    Label("记录", systemImage: "plus")
                }

            HistoryView()
                .tag(Tab.memories)
                .tabItem {
                    Label("那年今日", systemImage: "sparkles")
                }
        }
        .tint(Color.themePrimary)
    }
}
