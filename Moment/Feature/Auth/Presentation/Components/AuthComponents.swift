//
//  AuthComponents.swift
//  Moment
//
//  认证页面通用组件
//

import SwiftUI

// MARK: - 分隔线

struct AuthDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.themeSurfaceVariant)
            .frame(height: 1)
    }
}

// MARK: - Loading 遮罩

struct AuthLoadingOverlay: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            ProgressView()
                .tint(Color.themePrimary)
                .scaleEffect(1.5)
        }
    }
}

// MARK: - 装饰元素

struct AuthDecorations: View {
    var body: some View {
        ZStack {
            // 左下角装饰
            Circle()
                .fill(Color.themePrimary.opacity(0.1))
                .frame(width: 256, height: 256)
                .blur(radius: 40)
                .offset(x: -128, y: 100)
                .allowsHitTesting(false)

            // 右上角装饰
            Circle()
                .fill(Color.themeSecondaryContainer.opacity(0.1))
                .frame(width: 256, height: 256)
                .blur(radius: 40)
                .offset(x: 100, y: -100)
                .allowsHitTesting(false)
        }
    }
}

// MARK: - Footer

struct AuthFooter: View {
    var onPrivacyTap: (() -> Void)?
    var onTermsTap: (() -> Void)?
    var onSupportTap: (() -> Void)?

    var body: some View {
        VStack(spacing: 4) {
            Text("Life Archive")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.themeOnSurface)

            Text("© 2024 Life Archive. Preserving your digital heirloom.")
                .font(.system(size: 12))
                .foregroundStyle(Color.themeOnSurfaceVariant)

            HStack(spacing: Spacing.gutter) {
                footerLink("Privacy", action: { onPrivacyTap?() })
                footerLink("Terms", action: { onTermsTap?() })
                footerLink("Support", action: { onSupportTap?() })
            }
            .padding(.top, Spacing.unit)
        }
    }

    private func footerLink(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.themeOnSurfaceVariant)
        }
    }
}

// MARK: - Logo Header

struct AuthLogoHeader: View {
    var showBackButton: Bool = false
    var onBackTap: (() -> Void)?

    var body: some View {
        HStack {
            if showBackButton {
                Button(action: { onBackTap?() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(Color.themeOnSurface)
                }
            }

            Spacer()

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

            if showBackButton {
                Color.clear
                    .frame(width: 18, height: 18)
            }
        }
    }
}

#Preview("Divider") {
    AuthDivider()
        .padding()
}

#Preview("Loading") {
    AuthLoadingOverlay()
}

#Preview("Decorations") {
    ZStack {
        Color.themeBackground.ignoresSafeArea()
        AuthDecorations()
    }
}

#Preview("Footer") {
    AuthFooter()
        .padding()
}

#Preview("Logo Header") {
    VStack {
        AuthLogoHeader()
        AuthLogoHeader(showBackButton: true)
    }
    .padding()
}