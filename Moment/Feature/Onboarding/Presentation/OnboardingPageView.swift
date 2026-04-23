//
//  OnboardingPageView.swift
//  Moment
//
//  Onboarding 单页视图
//

import SwiftUI

struct OnboardingPageView: View {
    let pageIndex: Int
    let pageInfo: OnboardingPage
    let isActive: Bool
    var onActionButtonTap: (() -> Void)?
    var onSkipTap: (() -> Void)?

    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height

            ZStack {
                // 背景
                Color.themeBackground
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header
                    headerView
                        .padding(.horizontal, Spacing.containerMargin)
                        .padding(.top, Spacing.gutter)

                    Spacer()

                    // 插图区域
                    illustrationSection(size: geometry.size)
                        .padding(.horizontal, Spacing.containerMargin)

                    Spacer()
                        .frame(height: screenHeight * 0.05)

                    // 文字内容
                    textContentSection
                        .padding(.horizontal, Spacing.containerMargin)

                    Spacer()

                    // 底部导航
                    footerSection
                        .padding(.horizontal, Spacing.containerMargin)
                        .padding(.bottom, Spacing.stackLarge)
                }
                .frame(width: screenWidth, height: screenHeight)
            }
        }
    }

    // MARK: - Header

    private var headerView: some View {
        HStack {
            // Logo 文字
            HStack(spacing: Spacing.unit) {
                Image(systemName: "book.closed.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.themeSurfaceTint)

                Text("生命档案")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.themeOnSurface)
            }

            Spacer()

            // 跳过按钮
            Button(action: { onSkipTap?() }) {
                Text("跳过")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.themeOutline)
                    .tracking(0.65)
            }
        }
    }

    // MARK: - 插图区域

    @ViewBuilder
    private func illustrationSection(size: CGSize) -> some View {
        switch pageIndex {
        case 0:
            Page1Illustration(size: size)
        case 1:
            Page2Illustration(size: size)
        case 2:
            Page3Illustration(size: size)
        default:
            EmptyView()
        }
    }

    // MARK: - 文字内容

    private var textContentSection: some View {
        VStack(spacing: Spacing.stackSmall) {
            Text(pageInfo.title)
                .font(.themeHeadlineLarge)
                .foregroundStyle(Color.themeOnSurface)
                .tracking(-0.8)
                .multilineTextAlignment(.center)

            Text(pageInfo.description)
                .font(.themeBodyMedium)
                .foregroundStyle(Color.themeOnSurfaceVariant)
                .multilineTextAlignment(.center)
                .lineSpacing(8)
        }
    }

    // MARK: - 底部导航

    private var footerSection: some View {
        VStack(spacing: Spacing.stackMedium) {
            // 分页圆点
            paginationDots

            // 行动按钮
            actionButton
        }
    }

    private var paginationDots: some View {
        HStack(spacing: Spacing.unit) {
            ForEach(0..<3, id: \.self) { index in
                if index == pageIndex {
                    Capsule()
                        .fill(Color.themePrimary)
                        .frame(width: 24, height: 8)
                } else {
                    Circle()
                        .fill(Color.themePrimary.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }

    private var actionButton: some View {
        Button(action: { onActionButtonTap?() }) {
            HStack(spacing: Spacing.unit) {
                Text(pageInfo.buttonTitle)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.themeOnPrimaryContainer)

                if pageIndex < 2 {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.themeOnPrimaryContainer)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                Capsule()
                    .fill(Color.themePrimary)
                    .shadow(color: Color.themePrimary.opacity(0.3), radius: 12, x: 0, y: 8)
            )
        }
    }
}

#Preview {
    OnboardingPageView(
        pageIndex: 0,
        pageInfo: OnboardingPage.pages[0],
        isActive: true
    )
}