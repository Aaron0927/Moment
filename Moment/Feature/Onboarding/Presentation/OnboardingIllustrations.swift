//
//  OnboardingIllustrations.swift
//  Moment
//
//  Onboarding 页面插图
//

import SwiftUI

// MARK: - Page 1 插图：多维度记录

struct Page1Illustration: View {
    let size: CGSize

    private var illustrationSize: CGFloat {
        min(size.width * 0.74, 288)
    }

    var body: some View {
        ZStack {
            // 背景渐变圆
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.themePrimary.opacity(0.15),
                            Color.themePrimary.opacity(0)
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: illustrationSize / 2
                    )
                )
                .frame(width: illustrationSize, height: illustrationSize)
                .scaleEffect(0.85)

            // 相机 Tile - 左上
            cameraTile
                .offset(x: -illustrationSize * 0.15, y: -illustrationSize * 0.1)

            // 麦克风 Tile - 右下
            microphoneTile
                .offset(x: illustrationSize * 0.12, y: illustrationSize * 0.05)

            // 铅笔 Tile - 右侧
            pencilTile
                .offset(x: illustrationSize * 0.18, y: -illustrationSize * 0.05)
        }
        .frame(width: illustrationSize, height: illustrationSize)
    }

    // 相机卡片
    private var cameraTile: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.themeSurfaceContainer)
                .frame(width: 126, height: 126)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.themePrimaryFixed.opacity(0.7))
                )
                .overlay(
                    Image(systemName: "camera.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(Color.themeOnPrimaryContainer.opacity(0.5))
                )

            Image(systemName: "photo.stack")
                .font(.system(size: 22.5))
                .foregroundStyle(Color.themeOnSurfaceVariant)
        }
        .padding(17)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.themeSurfaceContainerLowest)
                .shadow(color: Color.themePrimary.opacity(0.1), radius: 30, x: 0, y: 8)
        )
        .rotationEffect(.degrees(-6))
    }

    // 麦克风卡片
    private var microphoneTile: some View {
        ZStack {
            Circle()
                .fill(Color.themeSecondaryContainer.opacity(0.3))
                .frame(width: 144, height: 144)
                .overlay(
                    Circle()
                        .stroke(Color.themeOutlineVariant, lineWidth: 1)
                )
                .shadow(color: Color.themeSecondary.opacity(0.1), radius: 20, x: 0, y: 8)

            Circle()
                .fill(Color.themeSurfaceContainerLowest)
                .frame(width: 64, height: 64)
                .overlay(
                    Image(systemName: "mic.fill")
                        .font(.system(size: 28.5))
                        .foregroundStyle(Color.themeOnSecondaryContainer)
                )
        }
        .rotationEffect(.degrees(12))
    }

    // 铅笔卡片
    private var pencilTile: some View {
        VStack(spacing: 8) {
            Image(systemName: "pencil.and.list.clipboard")
                .font(.system(size: 24))
                .foregroundStyle(Color.themeOnSurfaceVariant)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.themeSurfaceTint.opacity(0.2))
                .frame(width: 48, height: 4)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.themeSurfaceTint.opacity(0.2))
                .frame(width: 32, height: 4)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.themeSurfaceContainerLowest)
                .shadow(color: Color.themePrimary.opacity(0.1), radius: 20, x: 0, y: 8)
        )
        .rotationEffect(.degrees(15))
    }
}

// MARK: - Page 2 插图：优雅时间轴

struct Page2Illustration: View {
    let size: CGSize

    private var illustrationSize: CGFloat {
        min(size.width, 448)
    }

    var body: some View {
        ZStack {
            // 中央时间轴节点
            centerTimelineNode

            // 时间线
            timelineRail

            // 浮动卡片 - 左上
            floatingCard1
                .offset(x: -illustrationSize * 0.25, y: -illustrationSize * 0.15)
                .rotationEffect(.degrees(-6))

            // 浮动卡片 - 右下
            floatingCard2
                .offset(x: illustrationSize * 0.2, y: illustrationSize * 0.15)
                .rotationEffect(.degrees(-12))

            // 浮动卡片 - 右侧
            floatingCard3
                .offset(x: illustrationSize * 0.25, y: -illustrationSize * 0.05)
                .rotationEffect(.degrees(3))
        }
    }

    // 中央节点
    private var centerTimelineNode: some View {
        ZStack {
            Circle()
                .fill(Color.themePrimary)
                .frame(width: 64, height: 64)
                .overlay(
                    Circle()
                        .stroke(Color.themeBackground, lineWidth: 4)
                )
                .shadow(color: Color.themePrimary.opacity(0.4), radius: 40, x: 0, y: 0)

            Image(systemName: "play.fill")
                .font(.system(size: 15))
                .foregroundStyle(Color.themeOnPrimaryContainer)
        }
    }

    // 时间线
    private var timelineRail: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        Color.themeOutlineVariant.opacity(0),
                        Color.themeOutlineVariant.opacity(0.3),
                        Color.themeOutlineVariant.opacity(0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 4)
    }

    // 卡片1
    private var floatingCard1: some View {
        VStack(alignment: .leading, spacing: 4) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.themeSurfaceContainer)
                .frame(width: 100, height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.themePrimaryFixed.opacity(0.5))
                        .overlay(
                            Image(systemName: "photo.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(Color.themeOnPrimaryContainer.opacity(0.6))
                        )
                )

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.themePrimaryFixed)
                .frame(width: 48, height: 8)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.themeSurfaceContainer)
                .frame(height: 6)
        }
        .padding(9)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.themeSurfaceContainerLowest)
                .shadow(color: Color.themeSurfaceTint.opacity(0.08), radius: 25, x: 0, y: 10)
        )
    }

    // 卡片2
    private var floatingCard2: some View {
        VStack(alignment: .leading, spacing: 0) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.themeTertiaryFixed.opacity(0.2))
                .frame(width: 80, height: 80)
                .overlay(
                    VStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.themeSurfaceTint.opacity(0.2))
                            .frame(height: 8)
                        Spacer()
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.themeSurfaceTint.opacity(0.2))
                            .frame(width: 52, height: 8)
                    }
                    .padding(8)
                )
        }
        .padding(9)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.themeSurfaceContainerLowest)
                .shadow(color: Color.themeSurfaceTint.opacity(0.06), radius: 20, x: 0, y: 8)
        )
    }

    // 卡片3
    private var floatingCard3: some View {
        VStack(alignment: .leading, spacing: 0) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.themeSecondaryContainer.opacity(0.2))
                .frame(width: 90, height: 90)
                .overlay(
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(Color.themeOnSecondaryContainer.opacity(0.5))
                )
        }
        .padding(9)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.themeSurfaceContainerLowest)
                .shadow(color: Color.themeSurfaceTint.opacity(0.1), radius: 30, x: 0, y: 15)
        )
    }
}

// MARK: - Page 3 插图：安全与私密

struct Page3Illustration: View {
    let size: CGSize

    private var illustrationSize: CGFloat {
        min(size.width * 0.6, 200)
    }

    var body: some View {
        ZStack {
            // 外圈
            Circle()
                .stroke(Color.themeOutlineVariant, lineWidth: 2)
                .frame(width: illustrationSize * 1.2, height: illustrationSize * 1.2)

            // 内圈
            Circle()
                .fill(Color.themeSurfaceContainerLowest)
                .frame(width: illustrationSize, height: illustrationSize)
                .overlay(
                    Circle()
                        .stroke(Color.themePrimary.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: Color.themePrimary.opacity(0.1), radius: 30, x: 0, y: 10)

            // 盾牌图标
            Image(systemName: "lock.shield.fill")
                .font(.system(size: illustrationSize * 0.35))
                .foregroundStyle(Color.themePrimary)
        }
    }
}