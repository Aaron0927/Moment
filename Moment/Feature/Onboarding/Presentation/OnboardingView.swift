//
//  OnboardingView.swift
//  Moment
//
//  引导页主视图
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            Color.themeBackground
                .ignoresSafeArea()

            TabView(selection: $viewModel.currentPage) {
                ForEach(0..<viewModel.totalPages, id: \.self) { index in
                    OnboardingPageView(
                        pageIndex: index,
                        pageInfo: viewModel.pages[index],
                        isActive: viewModel.currentPage == index,
                        onActionButtonTap: {
                            if viewModel.currentPage < viewModel.totalPages - 1 {
                                viewModel.nextPage()
                            } else {
                                completeOnboarding()
                            }
                        },
                        onSkipTap: {
                            completeOnboarding()
                        }
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 0.3), value: viewModel.currentPage)
        }
    }

    private func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        authViewModel.completeOnboarding()
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AuthViewModel())
}
