//
//  RecordView.swift
//  Moment
//
//  记录页面视图
//

import SwiftUI

struct RecordView: View {
    @StateObject private var viewModel = RecordViewModel()
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
                            titleSection

                            recordTypeGrid

                            quickNoteSection

                            if viewModel.hasRecentFootprints {
                                recentFootprintsSection
                            }
                        }
                        .padding(.bottom, 128)
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
                    await viewModel.loadRecentFootprints()
                }
            }
        }
    }

    // MARK: - 头部

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
                // 设置操作
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

    // MARK: - 标题区域

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: Spacing.unit) {
            Text("今天想记录什么？")
                .font(.system(size: 48, weight: .medium))
                .foregroundStyle(Color.themeOnSurface)
                .tracking(-0.96)

            Text("每一个瞬间都值得被珍藏为数字遗产。")
                .font(.system(size: 16))
                .foregroundStyle(Color.themeOnSurfaceVariant)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.containerMargin)
    }

    // MARK: - 记录类型网格

    private var recordTypeGrid: some View {
        let columns = [
            GridItem(.flexible(), spacing: Spacing.gutter),
            GridItem(.flexible(), spacing: Spacing.gutter)
        ]

        return LazyVGrid(columns: columns, spacing: Spacing.gutter) {
            ForEach(RecordType.allCases) { type in
                RecordTypeButton(type: type)
            }
        }
        .padding(.horizontal, Spacing.containerMargin)
    }

    // MARK: - 快速感悟区域

    private var quickNoteSection: some View {
        VStack(alignment: .leading, spacing: Spacing.gutter) {
            HStack(spacing: Spacing.unit) {
                Image(systemName: "lightbulb.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.themeOnSurface)

                Text("快速感悟")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.themeOnSurface)
            }

            ZStack(alignment: .bottomTrailing) {
                TextEditor(text: $viewModel.quickNote)
                    .font(.system(size: 16))
                    .foregroundStyle(Color.themeOnSurface)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .frame(height: 128)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: RoundedCorner.default)
                            .fill(Color.themeSurface)
                    )
                    .overlay {
                        if viewModel.quickNote.isEmpty {
                            Text("此刻的心情是...")
                                .font(.system(size: 16))
                                .foregroundStyle(Color.themeOutline)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 16)
                                .allowsHitTesting(false)
                        }
                    }

                Button {
                    Task {
                        await viewModel.saveQuickNote()
                    }
                } label: {
                    Text("保存")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color.themePrimary)
                                .shadow(
                                    color: Color.themeSurfaceTint.opacity(0.05),
                                    radius: 2,
                                    x: 0,
                                    y: 1
                                )
                        )
                }
                .disabled(!viewModel.canSave)
                .opacity(viewModel.canSave ? 1 : 0.5)
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 32)
                .fill(Color.themeSurface.opacity(0.4))
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .fill(.ultraThinMaterial)
                )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 32)
                .strokeBorder(Color.themeOutline, lineWidth: 1)
        }
        .padding(.horizontal, Spacing.containerMargin)
    }

    // MARK: - 最近足迹区域

    private var recentFootprintsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.gutter) {
            HStack {
                Text("最近的足迹")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.themeOnSurfaceVariant)
                    .tracking(1.6)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.themeOnSurfaceVariant)
            }

            VStack(spacing: Spacing.gutter) {
                ForEach(viewModel.recentFootprints) { entry in
                    RecentFootprintRow(entry: entry)
                }
            }
        }
        .padding(.horizontal, Spacing.containerMargin)
        .padding(.top, Spacing.stackMedium)
    }
}

// MARK: - 记录类型按钮

struct RecordTypeButton: View {
    let type: RecordType

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: RoundedCorner.extraLarge)
                    .fill(Color.themeSecondaryContainer)
                    .frame(width: 56, height: 56)

                Image(systemName: type.iconName)
                    .font(.system(size: 20))
                    .foregroundStyle(Color.themeOnSurface)
            }

            Text(type.rawValue)
                .font(.system(size: 16))
                .foregroundStyle(Color.themeOnSurface)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 25)
        .background(
            RoundedRectangle(cornerRadius: RoundedCorner.extraLarge)
                .fill(Color.themeSurface)
                .shadow(
                    color: Color.themeSurfaceTint.opacity(0.05),
                    radius: 1,
                    x: 0,
                    y: 1
                )
        )
        .overlay {
            RoundedRectangle(cornerRadius: RoundedCorner.extraLarge)
                .strokeBorder(Color.themeOutline, lineWidth: 1)
        }
    }
}

// MARK: - 最近足迹行

struct RecentFootprintRow: View {
    let entry: TimelineEntry

    var body: some View {
        HStack(spacing: Spacing.gutter) {
            // 缩略图
            RoundedRectangle(cornerRadius: RoundedCorner.medium)
                .fill(entry.hasThumbnail ? Color.themeSecondaryContainer : Color.themeSecondaryContainer.opacity(0.5))
                .frame(width: 64, height: 64)
                .overlay {
                    if entry.hasThumbnail {
                        Image(systemName: entry.thumbnailName ?? "photo")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.themeOnSurface)
                    }
                }

            // 内容
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.themeOnSurface)
                    .lineLimit(1)

                Text(entry.relativeDateDescription)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.themeOnSurfaceVariant)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .foregroundStyle(Color.themeOnSurfaceVariant)
        }
        .padding(17)
        .background(
            RoundedRectangle(cornerRadius: RoundedCorner.large)
                .fill(Color.themeSurface)
                .shadow(
                    color: Color.themeSurfaceTint.opacity(0.05),
                    radius: 1,
                    x: 0,
                    y: 1
                )
        )
        .overlay {
            RoundedRectangle(cornerRadius: RoundedCorner.large)
                .strokeBorder(Color.themeOutline.opacity(0.5), lineWidth: 1)
        }
    }
}

#Preview {
    NavigationStack {
        RecordView()
    }
}
