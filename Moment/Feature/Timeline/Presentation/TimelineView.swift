//
//  TimelineView.swift
//  Moment
//
//  首页时间线视图
//

import SwiftUI

struct TimelineView: View {
    @StateObject private var viewModel = TimelineViewModel()
    @State private var selectedDate: Date = Date()
    @State private var navigationPath: [String] = []
    @State private var isShowingSettings: Bool = false

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.themeBackground
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    headerView

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: Spacing.stackMedium) {
                            dateSelectorSection

                            if viewModel.isEmpty {
                                emptyStateView
                            } else {
                                timelineListSection
                            }
                        }
                        .padding(.bottom, 100)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: String.self) { entryId in
                DetailView(entryId: entryId)
            }
            .navigationDestination(isPresented: $isShowingSettings) {
                SettingsView()
            }
            .onAppear {
                Task {
                    await viewModel.loadEntries()
                }
            }
        }
    }

    // MARK: - Header

    private var headerView: some View {
        HStack {
            Button {
                isShowingSettings = true
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

    // MARK: - 日期选择器

    private var dateSelectorSection: some View {
        DateSelectorView(selectedDate: $selectedDate) { date in
            viewModel.selectDate(date)
        }
    }

    // MARK: - 时间线列表

    private var timelineListSection: some View {
        TimelineListView(entries: viewModel.entries) { entryId in
            navigationPath.append(entryId)
        }
    }

    // MARK: - 空状态

    private var emptyStateView: some View {
        VStack(spacing: Spacing.stackMedium) {
            Image(systemName: "square-stack.3d.up.slash")
                .font(.system(size: 48))
                .foregroundStyle(Color.themeOnSurfaceVariant.opacity(0.5))

            Text("还没有记录")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.themeOnSurfaceVariant)

            Text("点击下方按钮开始记录")
                .font(.system(size: 14))
                .foregroundStyle(Color.themeOnSurfaceVariant.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.stackLarge)
    }
}

// MARK: - 时间线列表视图

struct TimelineListView: View {
    let entries: [TimelineEntry]
    let onEntryTap: (String) -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // 时间线竖线
            Rectangle()
                .fill(Color.themeOutline.opacity(0.3))
                .frame(width: 2)
                .padding(.leading, 16)

            // 条目列表
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(entries.enumerated()), id: \.element.id) { index, entry in
                    HStack(alignment: .top, spacing: 0) {
                        // 时间线节点
                        TimelineNodeView(isHighlighted: index == 0)
                            .padding(.leading, -20)
                            .padding(.top, 8)

                        // 卡片
                        TimelineCardView(entry: entry)
                            .padding(.leading, 16)
                            .onTapGesture {
                                onEntryTap(entry.id)
                            }
                    }
                    .padding(.bottom, Spacing.stackLarge)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 32)
    }
}

#Preview {
    NavigationStack {
        TimelineView()
    }
}
