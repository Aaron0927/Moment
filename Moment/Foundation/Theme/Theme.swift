//
//  Theme.swift
//  Moment
//
//  根据 DESIGN.md 构建的设计语义系统
//

import SwiftUI

// MARK: - 颜色语义

extension Color {
    /// 主色 - Soft Apricot
    static let themePrimary = Color("Primary")
    /// 次要色 - Sage Green
    static let themeSecondary = Color("Secondary")
    /// 次要容器色
    static let themeSecondaryContainer = Color("SecondaryContainer")
    /// 第三色
    static let themeTertiary = Color("Tertiary")
    /// 强调色
    static let themeSurfaceTint = Color("SurfaceTint")

    /// 表面色
    static let themeSurface = Color("Surface")
    static let themeSurfaceDim = Color("SurfaceDim")
    static let themeSurfaceBright = Color("SurfaceBright")
    static let themeSurfaceContainerLowest = Color("SurfaceContainerLowest")
    static let themeSurfaceContainerLow = Color("SurfaceContainerLow")
    static let themeSurfaceContainer = Color("SurfaceContainer")
    static let themeSurfaceContainerHigh = Color("SurfaceContainerHigh")
    static let themeSurfaceContainerHighest = Color("SurfaceContainerHighest")

    /// 表面变化色
    static let themeSurfaceVariant = Color("SurfaceVariant")

    /// 在表面上的颜色
    static let themeOnSurface = Color("OnSurface")
    static let themeOnSurfaceVariant = Color("OnSurfaceVariant")

    /// 反转表面色
    static let themeInverseSurface = Color("InverseSurface")
    static let themeInverseOnSurface = Color("InverseOnSurface")

    /// 边框
    static let themeOutline = Color("Outline")
    static let themeOutlineVariant = Color("OutlineVariant")

    /// 主要固定色
    static let themePrimaryFixed = Color("PrimaryFixed")
    static let themePrimaryFixedDim = Color("PrimaryFixedDim")
    static let themeOnPrimary = Color("OnPrimary")
    static let themeOnPrimaryContainer = Color("OnPrimaryContainer")

    /// 次要固定色
    static let themeSecondaryFixed = Color("SecondaryFixed")
    static let themeSecondaryFixedDim = Color("SecondaryFixedDim")
    static let themeOnSecondary = Color("OnSecondary")
    static let themeOnSecondaryContainer = Color("OnSecondaryContainer")

    /// 第三固定色
    static let themeTertiaryFixed = Color("TertiaryFixed")
    static let themeTertiaryFixedDim = Color("TertiaryFixedDim")
    static let themeOnTertiary = Color("OnTertiary")
    static let themeOnTertiaryContainer = Color("OnTertiaryContainer")

    /// 错误色
    static let themeError = Color("Error")
    static let themeOnError = Color("OnError")
    static let themeErrorContainer = Color("ErrorContainer")
    static let themeOnErrorContainer = Color("OnErrorContainer")

    /// 背景色
    static let themeBackground = Color("Background")
    static let themeOnBackground = Color("OnBackground")
}

// MARK: - 字体语义

extension Font {
    /// 显示字体 - 48px Bold
    static let themeDisplay = Font.system(size: 48, weight: .bold, design: .default)

    /// 标题大字 - 32px SemiBold
    static let themeHeadlineLarge = Font.system(size: 32, weight: .semibold, design: .default)

    /// 标题中字 - 24px SemiBold
    static let themeHeadlineMedium = Font.system(size: 24, weight: .semibold, design: .default)

    /// 正文大字 - 18px Regular
    static let themeBodyLarge = Font.system(size: 18, weight: .regular, design: .default)

    /// 正文中字 - 16px Regular
    static let themeBodyMedium = Font.system(size: 16, weight: .regular, design: .default)

    /// 标签小字 - 13px SemiBold Uppercase
    static let themeLabelSmall = Font.system(size: 13, weight: .semibold, design: .default)
}

// MARK: - 圆角语义

enum RoundedCorner {
    /// 小圆角 - 0.25rem (4px)
    static let small: CGFloat = 4
    /// 默认圆角 - 0.5rem (8px)
    static let `default`: CGFloat = 8
    /// 中圆角 - 0.75rem (12px)
    static let medium: CGFloat = 12
    /// 大圆角 - 1rem (16px)
    static let large: CGFloat = 16
    /// 大号圆角 - 1.5rem (24px)
    static let extraLarge: CGFloat = 24
    /// 全圆角
    static let full: CGFloat = 9999
}

// MARK: - 间距语义

enum Spacing {
    /// 基础单位 - 8px
    static let unit: CGFloat = 8
    /// 容器边距 - 24px
    static let containerMargin: CGFloat = 24
    ///  gutter - 16px
    static let gutter: CGFloat = 16
    /// 小间距 - 12px
    static let stackSmall: CGFloat = 12
    /// 中间距 - 24px
    static let stackMedium: CGFloat = 24
    /// 大间距 - 48px
    static let stackLarge: CGFloat = 48
}

// MARK: - 阴影语义

struct ThemeShadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat

    /// 环境阴影 - 低透明度，大模糊半径，Y偏移
    static let ambient = ThemeShadow(
        color: Color.themeSurfaceTint.opacity(0.1),
        radius: 20,
        x: 0,
        y: 4
    )

    /// 悬浮阴影 - 更大的模糊和偏移
    static let elevated = ThemeShadow(
        color: Color.themeSurfaceTint.opacity(0.15),
        radius: 30,
        x: 0,
        y: 8
    )
}

// MARK: - 过渡动画

enum ThemeAnimation {
    /// 标准过渡 - 200ms ease-in-out
    static let standard = SwiftUI.Animation.easeInOut(duration: 0.2)

    /// 快速过渡 - 150ms
    static let quick = SwiftUI.Animation.easeInOut(duration: 0.15)

    /// 慢速过渡 - 300ms
    static let slow = SwiftUI.Animation.easeInOut(duration: 0.3)
}
