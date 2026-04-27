//
//  SettingsView.swift
//  Moment
//
//  设置页面视图
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var viewModel = SettingsViewModel(repository: SettingsRepositoryImpl())
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // 背景色
            Color.themeBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // 顶部导航栏
                topNavigationBar

                // 主内容
                ScrollView {
                    VStack(spacing: Spacing.stackMedium) {
                        // 用户信息卡片
                        userProfileCard

                        // 偏好设置区域
                        preferencesSection

                        // 数据与存储区域
                        dataStorageSection

                        // 关于区域
                        aboutSection

                        // 退出登录按钮
                        logoutSection
                    }
                    .padding(.horizontal, Spacing.gutter)
                    .padding(.top, Spacing.stackMedium)
                    .padding(.bottom, 96)
                }
            }
        }
        .navigationBarHidden(true)
        .alert("退出登录", isPresented: $viewModel.showLogoutConfirmation) {
            Button("取消", role: .cancel) {
                viewModel.cancelLogout()
            }
            Button("退出", role: .destructive) {
                viewModel.confirmLogout()
            }
        } message: {
            Text("确定要退出登录吗？")
        }
    }

    // MARK: - 顶部导航栏

    private var topNavigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.themeOnSurface)
            }

            Spacer()

            Text("设置")
                .font(.themeHeadlineMedium)
                .foregroundStyle(Color.themeOnSurface)

            Spacer()

            Button {
                // 暂无功能
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.themeOnSurface)
            }
        }
        .padding(.horizontal, Spacing.gutter)
        .padding(.vertical, Spacing.gutter)
        .background(Color.themeBackground)
        .shadow(color: .black.opacity(0.05), radius: 1, y: 1)
    }

    // MARK: - 用户信息卡片

    private var userProfileCard: some View {
        HStack(spacing: Spacing.gutter) {
            // 头像
            ZStack {
                Circle()
                    .fill(Color.themePrimaryFixedDim)
                    .frame(width: 64, height: 64)

                if let avatarURL = viewModel.currentUser?.avatarURL {
                    AsyncImage(url: avatarURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Text(String(viewModel.currentUser?.displayName.prefix(1) ?? "U"))
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(Color.themeOnPrimary)
                    }
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                } else {
                    Text(String(viewModel.currentUser?.displayName.prefix(1) ?? "U"))
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(Color.themeOnPrimary)
                }
            }
            .overlay(
                Circle()
                    .stroke(Color.themePrimary, lineWidth: 2)
            )
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 21))
                    .foregroundStyle(Color.themePrimary)
                    .background(Circle().fill(Color.themeBackground))
            }

            Spacer()

            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.currentUser?.displayName ?? "用户")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(Color.themeOnSurface)

                Button {
                    viewModel.navigateToProfile()
                } label: {
                    HStack(spacing: 4) {
                        Text("查看个人资料")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.themeOnSurfaceVariant)

                        Image(systemName: "chevron.right")
                            .font(.system(size: 7, weight: .semibold))
                            .foregroundStyle(Color.themeOnSurfaceVariant)
                    }
                }
            }

            Spacer()
        }
        .padding(Spacing.gutter)
        .background(
            RoundedRectangle(cornerRadius: RoundedCorner.medium)
                .fill(Color.themeSurface)
                .shadow(color: .black.opacity(0.08), radius: 20, y: 15)
        )
    }

    // MARK: - 偏好设置区域

    private var preferencesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.stackSmall) {
            Text("PREFERENCES")
                .font(.themeLabelSmall)
                .foregroundStyle(Color.themeOnSurfaceVariant)
                .tracking(1.3)

            VStack(spacing: 0) {
                settingsRow(
                    icon: "globe",
                    iconBackgroundColor: Color(hex: "FFDBCD"),
                    title: "语言设置",
                    value: "中文"
                )

                Divider()
                    .background(Color.themeOutlineVariant)

                settingsRow(
                    icon: "sun.max",
                    iconBackgroundColor: Color(hex: "DAE8BE"),
                    title: "主题模式",
                    value: "浅色"
                )

                Divider()
                    .background(Color.themeOutlineVariant)

                settingsRow(
                    icon: "bell",
                    iconBackgroundColor: Color(hex: "E7E2D9"),
                    title: "通知提醒",
                    value: nil,
                    showArrow: true
                )
            }
            .background(
                RoundedRectangle(cornerRadius: RoundedCorner.medium)
                    .fill(Color.themeSurface)
                    .shadow(color: .black.opacity(0.08), radius: 20, y: 15)
            )
        }
    }

    // MARK: - 数据与存储区域

    private var dataStorageSection: some View {
        VStack(alignment: .leading, spacing: Spacing.stackSmall) {
            Text("DATA & STORAGE")
                .font(.themeLabelSmall)
                .foregroundStyle(Color.themeOnSurfaceVariant)
                .tracking(1.3)

            VStack(spacing: 0) {
                settingsRow(
                    icon: "icloud",
                    iconBackgroundColor: Color(hex: "FFEDD5"),
                    title: "云端同步",
                    value: nil,
                    showArrow: true
                )

                Divider()
                    .background(Color.themeOutlineVariant)

                settingsRow(
                    icon: "square.and.arrow.up",
                    iconBackgroundColor: Color(hex: "F5F5F4"),
                    title: "数据导出",
                    value: nil,
                    showArrow: true
                )
            }
            .background(
                RoundedRectangle(cornerRadius: RoundedCorner.medium)
                    .fill(Color.themeSurface)
                    .shadow(color: .black.opacity(0.08), radius: 20, y: 15)
            )
        }
    }

    // MARK: - 关于区域

    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: Spacing.stackSmall) {
            Text("ABOUT")
                .font(.themeLabelSmall)
                .foregroundStyle(Color.themeOnSurfaceVariant)
                .tracking(1.3)

            VStack(spacing: 0) {
                settingsRow(
                    icon: "info.circle",
                    iconBackgroundColor: Color(hex: "F0EDED"),
                    title: "关于我们",
                    value: nil,
                    showArrow: true
                )

                Divider()
                    .background(Color.themeOutlineVariant)

                settingsRow(
                    icon: "lock.shield",
                    iconBackgroundColor: Color(hex: "F0EDED"),
                    title: "隐私政策",
                    value: nil,
                    showArrow: true
                )
            }
            .background(
                RoundedRectangle(cornerRadius: RoundedCorner.medium)
                    .fill(Color.themeSurface)
                    .shadow(color: .black.opacity(0.08), radius: 20, y: 15)
            )
        }
    }

    // MARK: - 退出登录区域

    private var logoutSection: some View {
        VStack(spacing: Spacing.stackSmall) {
            Button {
                viewModel.requestLogout()
            } label: {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 18))
                        .foregroundStyle(Color.themeError)

                    Text("退出登录")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(Color.themeError)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            }
            .overlay(
                RoundedRectangle(cornerRadius: RoundedCorner.medium)
                    .stroke(Color.themeError.opacity(0.2), lineWidth: 2)
            )

            Text("Version 2.4.1 (Life Archive)")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.themeOnSurfaceVariant)
                .padding(.top, 4)
        }
        .padding(.top, Spacing.stackMedium)
    }

    // MARK: - 设置行组件

    private func settingsRow(
        icon: String,
        iconBackgroundColor: Color,
        title: String,
        value: String?,
        showArrow: Bool = false
    ) -> some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: RoundedCorner.default)
                    .fill(iconBackgroundColor)
                    .frame(width: 40, height: 40)

                Image(systemName: icon)
                    .font(.system(size: icon == "bell" ? 14 : 18))
                    .foregroundStyle(Color.themeOnSurface)
            }

            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.themeOnSurface)

            Spacer()

            if let value {
                Text(value)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.themeOnSurfaceVariant)
            }

            if showArrow {
                Image(systemName: "chevron.right")
                    .font(.system(size: 7, weight: .semibold))
                    .foregroundStyle(Color.themeOnSurfaceVariant)
            }
        }
        .padding(Spacing.gutter)
    }
}

// MARK: - 颜色扩展

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
}
