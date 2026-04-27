//
//  DetailView.swift
//  Moment
//
//  卡片详情页面
//

import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel = DetailViewModel()
    @Environment(\.dismiss) private var dismiss

    let entryId: String

    var body: some View {
        ZStack {
            // 背景色
            Color.themeBackground
                .ignoresSafeArea()

            if viewModel.isLoading {
                ProgressView()
            } else if let entry = viewModel.entry {
                ScrollView {
                    VStack(spacing: 0) {
                        heroImageSection(entry)
                        contentSection(entry)
                    }
                }
                .ignoresSafeArea(edges: .top)

                // 顶部导航栏
                topNavigationBar
                    .frame(maxHeight: .infinity, alignment: .top)

                // 底部导航栏
                bottomNavigationBar
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .task {
            await viewModel.loadDetail(id: entryId)
        }
        .navigationBarHidden(true)
    }

    // MARK: - 英雄图区域

    @ViewBuilder
    private func heroImageSection(_ entry: DetailEntry) -> some View {
        ZStack(alignment: .bottomLeading) {
            // 图片或占位符
            if let imageURL = entry.imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    heroPlaceholder
                }
            } else {
                heroPlaceholder
            }

            // 渐变遮罩
            LinearGradient(
                colors: [
                    Color.themeBackground.opacity(0),
                    Color.themeBackground.opacity(0.5),
                    Color.themeBackground
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            // 浮动元数据
            VStack(alignment: .leading, spacing: 7) {
                // 分类标签
                Text(entry.tag)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.themeSecondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 3.5)
                    .background(
                        Capsule()
                            .fill(Color.themeSecondary.opacity(0.2))
                    )

                // 标题
                Text(entry.title)
                    .font(.themeHeadlineLarge)
                    .foregroundStyle(Color.themeOnSurface)
            }
            .padding(.horizontal, Spacing.containerMargin)
            .padding(.bottom, 40)
        }
        .frame(height: 530)
    }

    private var heroPlaceholder: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [Color.themeSurfaceContainerHigh, Color.themeSurfaceContainerLow],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }

    // MARK: - 内容区域

    @ViewBuilder
    private func contentSection(_ entry: DetailEntry) -> some View {
        VStack(alignment: .leading, spacing: Spacing.stackMedium) {
            // 日期和位置
            detailsRow(entry)

            // 语音播放器（如有）
            if entry.voiceURL != nil {
                voicePlayer(entry)
            }

            // 文本内容
            Text(entry.content)
                .font(.themeBodyLarge)
                .foregroundStyle(Color.themeOnSurface)
                .lineSpacing(6)
                .padding(.horizontal, Spacing.containerMargin)

            // 情绪标签
            if !entry.tags.isEmpty {
                tagsSection(entry.tags)
            }

            // 相关回忆
            relatedMemoriesSection

            // 底部留白
            Spacer()
                .frame(height: 144)
        }
        .padding(.top, 16)
    }

    // MARK: - 日期和位置

    @ViewBuilder
    private func detailsRow(_ entry: DetailEntry) -> some View {
        VStack(alignment: .leading, spacing: Spacing.unit * 2) {
            // 日期时间
            HStack(spacing: 6) {
                Image(systemName: "clock")
                    .font(.system(size: 13.5))
                    .foregroundStyle(Color.themeOnSurfaceVariant)

                Text(viewModel.formattedRecordTime(entry.recordedAt))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.themeOnSurfaceVariant)
            }

            // 位置
            if let location = entry.location {
                HStack(spacing: 6) {
                    Image(systemName: "location")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.themeOnSurfaceVariant)

                    Text(location)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.themeOnSurfaceVariant)
                }
            }
        }
        .padding(.horizontal, Spacing.containerMargin)
        .padding(.bottom, 25)
        .overlay(alignment: .bottom) {
            Divider()
                .background(Color.themeOutlineVariant.opacity(0.3))
        }
    }

    // MARK: - 语音播放器

    @ViewBuilder
    private func voicePlayer(_ entry: DetailEntry) -> some View {
        HStack(spacing: Spacing.gutter) {
            // 播放按钮
            Button {
                // TODO: 播放语音
            } label: {
                Circle()
                    .fill(Color.themePrimary)
                    .frame(width: 56, height: 56)
                    .overlay {
                        Image(systemName: "play.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.themeOnPrimary)
                    }
            }

            // 进度条
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("语音随记")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.themeOnSurfaceVariant)

                    Spacer()

                    Text(viewModel.formattedVoiceDuration(entry.voiceDuration ?? 0))
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.themeOnSurfaceVariant)
                }

                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.themeOutlineVariant.opacity(0.2))
                            .frame(height: 6)

                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.themePrimary)
                            .frame(width: geometry.size.width * 0.667, height: 6)
                    }
                }
                .frame(height: 6)
            }
        }
        .padding(Spacing.gutter)
        .background {
            RoundedRectangle(cornerRadius: RoundedCorner.extraLarge)
                .fill(Color.themeSurfaceContainerHigh)
                .shadow(
                    color: Color.themeOnSurface.opacity(0.05),
                    radius: 1,
                    x: 0,
                    y: 1
                )
        }
        .padding(.horizontal, Spacing.containerMargin)
    }

    // MARK: - 标签区域

    @ViewBuilder
    private func tagsSection(_ tags: [String]) -> some View {
        HStack(spacing: 8) {
            ForEach(tags, id: \.self) { tag in
                HStack(spacing: 4) {
                    Image(systemName: "tag")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.themeOnSurfaceVariant)

                    Text(tag)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.themeOnSurfaceVariant)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.themeSurfaceContainerHigh)
                )
            }
        }
        .padding(.horizontal, Spacing.containerMargin)
    }

    // MARK: - 相关回忆

    @ViewBuilder
    private var relatedMemoriesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.gutter + 4) {
            // 标题行
            HStack {
                Text("相关回忆")
                    .font(.themeHeadlineMedium)
                    .foregroundStyle(Color.themeOnSurface)

                Spacer()

                Button {
                    // TODO: 查看全部
                } label: {
                    Text("查看全部")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.themePrimary)
                }
            }
            .padding(.horizontal, 4)

            // 缩略图列表
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.relatedMemories) { memory in
                        relatedMemoryCard(memory)
                    }
                }
            }
        }
        .padding(.top, Spacing.stackLarge)
        .padding(.horizontal, 4)
    }

    @ViewBuilder
    private func relatedMemoryCard(_ memory: RelatedMemory) -> some View {
        VStack(alignment: .leading, spacing: 9) {
            // 缩略图
            RoundedRectangle(cornerRadius: RoundedCorner.large)
                .fill(Color.themeSurfaceContainerHigh)
                .frame(width: 160, height: 158)
                .overlay {
                    if let imageURL = memory.imageURL {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "photo")
                                .font(.system(size: 24))
                                .foregroundStyle(Color.themeOnSurfaceVariant)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: RoundedCorner.large))
                    } else {
                        Image(systemName: "photo")
                            .font(.system(size: 24))
                            .foregroundStyle(Color.themeOnSurfaceVariant)
                    }
                }
                .shadow(
                    color: Color.themeOnSurface.opacity(0.05),
                    radius: 1,
                    x: 0,
                    y: 1
                )

            // 标题
            Text(memory.title)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.themeOnSurface)
                .lineLimit(1)

            // 日期
            Text(memory.formattedDate)
                .font(.system(size: 11))
                .foregroundStyle(Color.themeOnSurfaceVariant)
        }
        .frame(width: 160)
    }

    // MARK: - 顶部导航栏

    private var topNavigationBar: some View {
        HStack {
            // 返回按钮
            Button {
                dismiss()
            } label: {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.themeOnSurface)
                    }
            }

            Spacer()

            // 右侧按钮
            HStack(spacing: 8) {
                Button {
                    // TODO: 分享
                } label: {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 16))
                                .foregroundStyle(Color.themeOnSurface)
                        }
                }

                Button {
                    // TODO: 更多选项
                } label: {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 16))
                                .foregroundStyle(Color.themeOnSurface)
                        }
                }
            }
        }
        .padding(.horizontal, Spacing.containerMargin)
        .padding(.top, 16)
        .padding(.bottom, 17)
        .background {
            LinearGradient(
                colors: [
                    Color.themeSurface.opacity(0.4),
                    Color.themeSurface.opacity(0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }

    // MARK: - 底部导航栏

    private var bottomNavigationBar: some View {
        HStack(spacing: 41.6) {
            // 时间轴
            navItem(
                icon: "clock.fill",
                title: "时间轴",
                isSelected: true
            )

            // 记录
            navItem(
                icon: "plus",
                title: "记录",
                isSelected: false
            )

            // 那年今日
            navItem(
                icon: "sparkles",
                title: "那年今日",
                isSelected: false
            )
        }
        .padding(.horizontal, 36.83)
        .padding(.vertical, 13)
        .background {
            Capsule()
                .fill(.ultraThinMaterial)
                .shadow(
                    color: Color.themeOutlineVariant.opacity(0.3),
                    radius: 15,
                    x: 0,
                    y: -10
                )
        }
        .padding(.horizontal, Spacing.containerMargin)
        .padding(.bottom, 24)
        .background {
            LinearGradient(
                colors: [
                    Color.themeSurface.opacity(0),
                    Color.themeSurface.opacity(0.9)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }

    @ViewBuilder
    private func navItem(icon: String, title: String, isSelected: Bool) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: isSelected ? 20 : 20))
                .foregroundStyle(isSelected ? Color.themePrimary : Color.themeOnSurfaceVariant)

            Text(title)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(isSelected ? Color.themePrimary : Color.themeOnSurfaceVariant)
        }
        .frame(width: 60)
    }
}

#Preview {
    DetailView(entryId: "1")
}
