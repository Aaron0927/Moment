//
//  SocialLoginButtons.swift
//  Moment
//
//  社交登录按钮组件
//

import SwiftUI

struct SocialLoginButtons: View {
    var onAppleTap: (() -> Void)?
    var onWeChatTap: (() -> Void)?

    var body: some View {
        HStack(spacing: Spacing.gutter) {
            SocialButton(
                title: "Apple",
                icon: "apple.logo",
                action: { onAppleTap?() }
            )

            SocialButton(
                title: "WeChat",
                icon: "message.fill",
                action: { onWeChatTap?() }
            )
        }
    }
}

struct SocialButton: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.themeOnSurface)

                Text(title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color.themeOnSurface)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 11)
            .background(
                RoundedRectangle(cornerRadius: RoundedCorner.default)
                    .stroke(Color.themeSurfaceVariant, lineWidth: 1)
            )
        }
    }
}

#Preview {
    SocialLoginButtons()
        .padding()
        .background(Color.themeBackground)
}