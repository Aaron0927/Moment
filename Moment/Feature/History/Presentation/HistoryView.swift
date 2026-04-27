//
//  HistoryView.swift
//  Moment
//
//  那年今日视图
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.themeBackground
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    headerView

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: Spacing.stackLarge) {
                            dateHeaderSection

                            if viewModel.isLoading {
                                loadingView
                            } else if viewModel.isEmpty {
                                emptyStateView
                            } else {
                                memoryGroupsSection
                            }

                            endOfTimelineView
                        }
                        .padding(.horizontal, Spacing.containerMargin)
                        .padding(.bottom, 120)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: SettingsNavigationDestination.self) { destination in
                SettingsView()
                    .id(destination.id)
            }
            .onAppear {
                Task {
                    await viewModel.loadMemories()
                }
            }
        }
    }

    // MARK: - Header

    private var headerView: some View {
        HStack {
            Button {
                navigationPath.append(SettingsNavigationDestination())
            } label: {
                HStack(spacing: Spacing.stackSmall) {
                    Circle()
                        .fill(Color.themeSecondary)
                        .frame(width: 32, height: 32)
                        .overlay {
                            Image(systemName: "person.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.themeOnSecondary)
                        }

                    Text("生活志")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(Color.themeOnSurface)
                }
            }

            Spacer()

            Button {
                // 更多操作
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.themeOnSurface)
            }
        }
        .padding(.horizontal, Spacing.containerMargin)
        .padding(.vertical, Spacing.gutter)
        .background(Color.themeSurface)
    }

    // MARK: - 日期标题

    private var dateHeaderSection: some View {
        VStack(spacing: Spacing.stackSmall) {
            Text(viewModel.currentMonthDay)
                .font(.themeLabelSmall)
                .foregroundStyle(Color.themePrimary)
                .tracking(1.3)

            Text("穿越时光的温存")
                .font(.themeDisplay)
                .foregroundStyle(Color.themeOnSurface)

            Rectangle()
                .fill(Color.themePrimary)
                .frame(width: 48, height: 4)
                .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.stackMedium)
    }

    // MARK: - 记忆分组

    private var memoryGroupsSection: some View {
        VStack(spacing: Spacing.stackLarge) {
            ForEach(viewModel.memoryGroups) { group in
                MemoryGroupView(group: group)
            }
        }
    }

    // MARK: - 加载中

    private var loadingView: some View {
        VStack(spacing: Spacing.stackMedium) {
            ProgressView()
                .tint(Color.themePrimary)

            Text("正在加载...")
                .font(.themeBodyMedium)
                .foregroundStyle(Color.themeOnSurfaceVariant)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.stackLarge)
    }

    // MARK: - 空状态

    private var emptyStateView: some View {
        VStack(spacing: Spacing.stackMedium) {
            Image(systemName: "clock.arrow.circlepath")
                .font(.system(size: 48))
                .foregroundStyle(Color.themeOnSurfaceVariant.opacity(0.5))

            Text("暂无回忆")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.themeOnSurfaceVariant)

            Text("记录生活，留住回忆")
                .font(.system(size: 14))
                .foregroundStyle(Color.themeOnSurfaceVariant.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.stackLarge)
    }

    // MARK: - 时间线尽头

    private var endOfTimelineView: some View {
        VStack(spacing: Spacing.stackSmall) {
            Image(systemName: "sparkles")
                .font(.system(size: 24))
                .foregroundStyle(Color.themeOnSurfaceVariant.opacity(0.5))

            Text("故事还在继续...")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.themeOnSurfaceVariant)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.stackLarge)
    }
}

// MARK: - 记忆分组视图

struct MemoryGroupView: View {
    let group: MemoryGroup

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.stackMedium) {
            yearBadge

            ForEach(group.entries) { entry in
                switch entry.memoryType {
                case .photo:
                    PhotoMemoryCard(entry: entry)
                case .text:
                    TextReflectionCard(entry: entry)
                case .video:
                    VideoThumbnailCard(entry: entry)
                }
            }
        }
    }

    private var yearBadge: some View {
        HStack {
            Spacer()

            Text(group.yearLabel)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(yearBadgeTextColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(yearBadgeBackgroundColor)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
    }

    private var yearBadgeBackgroundColor: Color {
        switch group.yearsAgo {
        case 1:
            return Color(red: 1.0, green: 0.86, blue: 0.80) // #ffdbcd
        case 3:
            return Color(red: 0.84, green: 0.90, blue: 0.73) // #d7e5bb
        default:
            return Color(red: 0.91, green: 0.89, blue: 0.85) // #e7e2d9
        }
    }

    private var yearBadgeTextColor: Color {
        switch group.yearsAgo {
        case 1:
            return Color(red: 0.21, green: 0.06, blue: 0.0) // #360f00
        case 3:
            return Color(red: 0.35, green: 0.40, blue: 0.27) // #5a6745
        default:
            return Color(red: 0.11, green: 0.11, blue: 0.09) // #1d1b16
        }
    }
}

// MARK: - 照片记忆卡片

struct PhotoMemoryCard: View {
    let entry: MemoryEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 图片区域
            ZStack {
                if let imageURL = entry.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        placeholderImage
                    }
                } else {
                    placeholderImage
                }
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .clipped()

            // 内容区域
            VStack(alignment: .leading, spacing: Spacing.unit + 2) {
                if let title = entry.title, !title.isEmpty {
                    HStack(spacing: 8) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.themePrimary)

                        Text(title)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.themePrimary)
                    }
                }

                if let title = entry.title, !title.isEmpty {
                    Text(title)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(Color.themeOnSurface)
                        .lineLimit(2)
                }

                if let content = entry.content, !content.isEmpty {
                    Text(content)
                        .font(.system(size: 16))
                        .foregroundStyle(Color(red: 0.33, green: 0.27, blue: 0.24))
                        .lineLimit(4)
                }
            }
            .padding(Spacing.gutter)
            .frame(maxWidth: .infinity, alignment: .leading)

            // 底部日期
            HStack {
                Text(entry.formattedDate)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.themeOnSurfaceVariant)
                    .tracking(0.65)

                Spacer()

                Image(systemName: "heart.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.themePrimary.opacity(0.6))
            }
            .padding(.horizontal, Spacing.gutter)
            .padding(.vertical, 13)
            .overlay(alignment: .top) {
                Divider()
                    .background(Color.themeOutline.opacity(0.3))
            }
        }
        .background(Color(red: 0.99, green: 0.98, blue: 0.97))
        .clipShape(RoundedRectangle(cornerRadius: RoundedCorner.medium))
        .overlay {
            RoundedRectangle(cornerRadius: RoundedCorner.medium)
                .stroke(Color.themeOutline, lineWidth: 1)
        }
        .shadow(
            color: Color.themePrimary.opacity(0.08),
            radius: 20,
            x: 0,
            y: 4
        )
    }

    var placeholderImage: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        Color.themePrimary.opacity(0.3),
                        Color.themePrimary.opacity(0.1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                Image(systemName: "photo")
                    .font(.system(size: 32))
                    .foregroundStyle(Color.themePrimary.opacity(0.5))
            }
    }
}

// MARK: - 文字回忆卡片

struct TextReflectionCard: View {
    let entry: MemoryEntry

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.gutter) {
            Image(systemName: "quote.opening")
                .font(.system(size: 20))
                .foregroundStyle(Color.themePrimary.opacity(0.7))
                .padding(.top, 4)

            VStack(alignment: .leading, spacing: Spacing.unit) {
                if let content = entry.content {
                    Text(content)
                        .font(.system(size: 24, weight: .medium))
                        .italic()
                        .foregroundStyle(Color.themePrimary)
                        .lineSpacing(8)
                }
            }
        }
        .padding(Spacing.gutter + 9)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.themeSurface)
        .clipShape(RoundedRectangle(cornerRadius: RoundedCorner.medium))
        .overlay {
            RoundedRectangle(cornerRadius: RoundedCorner.medium)
                .stroke(Color.themeOutline, lineWidth: 1)
        }
        .shadow(
            color: Color.themePrimary.opacity(0.05),
            radius: 15,
            x: 0,
            y: 3
        )
    }
}

// MARK: - 视频缩略图卡片

struct VideoThumbnailCard: View {
    let entry: MemoryEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                if let imageURL = entry.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        videoPlaceholder
                    }
                } else {
                    videoPlaceholder
                }

                // 播放按钮
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 64, height: 64)
                    .overlay {
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    }
                    .overlay {
                        Image(systemName: "play.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                    }

                // 底部信息
                VStack {
                    Spacer()
                    HStack {
                        if let duration = entry.videoDuration {
                            Text(formatDuration(duration))
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.white.opacity(0.8))
                        }

                        if let title = entry.title, !title.isEmpty {
                            Text("•")
                                .foregroundStyle(.white.opacity(0.8))
                            Text(title)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.white.opacity(0.8))
                                .lineLimit(1)
                        }

                        Spacer()
                    }
                    .padding(.horizontal, Spacing.gutter)
                    .padding(.bottom, 15.69)
                }
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .clipped()
        }
        .background(Color.themeSurface)
        .clipShape(RoundedRectangle(cornerRadius: RoundedCorner.medium))
        .overlay {
            RoundedRectangle(cornerRadius: RoundedCorner.medium)
                .stroke(Color.themeOutline, lineWidth: 1)
        }
        .shadow(
            color: Color.themePrimary.opacity(0.05),
            radius: 15,
            x: 0,
            y: 3
        )
    }

    private var videoPlaceholder: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.6, green: 0.4, blue: 0.2),
                        Color(red: 0.9, green: 0.6, blue: 0.3)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }

    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

// MARK: - 标签视图

struct TagView: View {
    let tag: String

    var body: some View {
        Text(tag)
            .font(.system(size: 12, weight: .medium))
            .foregroundStyle(Color(red: 0.25, green: 0.30, blue: 0.17))
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(Color(red: 0.75, green: 0.80, blue: 0.64).opacity(0.3))
            .clipShape(Capsule())
    }
}

#Preview {
    NavigationStack {
        HistoryView()
    }
}
