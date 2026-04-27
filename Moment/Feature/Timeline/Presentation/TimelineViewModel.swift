//
//  TimelineViewModel.swift
//  Moment
//
//  时间线视图模型
//

import Foundation
import Combine
import SwiftData

@MainActor
final class TimelineViewModel: ObservableObject {
    /// 当前选中日期
    @Published var selectedDate: Date = Date()

    /// 当前日期的条目列表
    @Published private(set) var entries: [TimelineEntry] = []

    /// 加载状态
    @Published private(set) var isLoading: Bool = false

    /// 错误信息
    @Published var errorMessage: String?

    private let repository: TimelineRepository?

    /// 用于预览的初始化
    init() {
        self.repository = nil
    }

    /// 正式初始化
    init(repository: TimelineRepository) {
        self.repository = repository
    }

    /// 加载指定日期的条目
    func loadEntries() async {
        guard let repository else {
            // 预览模式使用示例数据
            entries = TimelineEntry.sampleEntries
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            entries = try await repository.entries(for: selectedDate)
        } catch {
            errorMessage = "加载失败: \(error.localizedDescription)"
        }

        isLoading = false
    }

    /// 加载最近条目 (用于无日期数据时显示)
    func loadRecentEntries() async {
        guard let repository else {
            entries = TimelineEntry.sampleEntries
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            entries = try await repository.recentEntries(limit: 20)
        } catch {
            errorMessage = "加载失败: \(error.localizedDescription)"
        }

        isLoading = false
    }

    /// 选择日期
    func selectDate(_ date: Date) {
        selectedDate = date
        Task {
            await loadEntries()
        }
    }

    /// 是否显示空状态
    var isEmpty: Bool {
        entries.isEmpty && !isLoading
    }
}