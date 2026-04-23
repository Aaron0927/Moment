//
//  OnboardingViewModel.swift
//  Moment
//
//  Onboarding ViewModel
//

import SwiftUI
import Combine

@MainActor
final class OnboardingViewModel: ObservableObject {
    // MARK: - 状态

    @Published var currentPage: Int = 0
    @Published var isLastPage: Bool = false

    let totalPages: Int = OnboardingPage.pages.count

    var pages: [OnboardingPage] {
        OnboardingPage.pages
    }

    // MARK: - 操作

    func nextPage() {
        guard currentPage < totalPages - 1 else { return }
        currentPage += 1
        updateLastPageState()
    }

    func previousPage() {
        guard currentPage > 0 else { return }
        currentPage -= 1
        updateLastPageState()
    }

    func skip() {
        currentPage = totalPages - 1
        updateLastPageState()
    }

    func goToPage(_ page: Int) {
        guard page >= 0, page < totalPages else { return }
        currentPage = page
        updateLastPageState()
    }

    private func updateLastPageState() {
        isLastPage = currentPage == totalPages - 1
    }
}