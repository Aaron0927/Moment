//
//  RecordViewModel.swift
//  Moment
//
//  记录页面视图模型
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class RecordViewModel: ObservableObject {
    /// 快速感悟文本
    @Published var quickNote: String = ""

    /// 最近足迹列表 (最多显示3条)
    @Published private(set) var recentFootprints: [TimelineEntry] = []

    /// 加载状态
    @Published private(set) var isLoading: Bool = false

    /// 错误信息
    @Published var errorMessage: String?

    /// 是否正在保存
    @Published private(set) var isSaving: Bool = false

    private let repository: RecordRepository?

    /// 预览初始化
    init() {
        self.repository = nil
    }

    /// 正式初始化
    init(repository: RecordRepository) {
        self.repository = repository
    }

    /// 加载最近足迹 (最多3条)
    func loadRecentFootprints() async {
        guard let repository else {
            // 预览模式使用示例数据
            recentFootprints = Array(TimelineEntry.sampleEntries.prefix(3))
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let entries = try await repository.recentFootprints(limit: 3)
            recentFootprints = Array(entries.prefix(3))
        } catch {
            errorMessage = "加载失败: \(error.localizedDescription)"
        }

        isLoading = false
    }

    /// 保存快速感悟
    func saveQuickNote() async -> Bool {
        guard !quickNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }

        guard let repository else {
            // 预览模式
            quickNote = ""
            return true
        }

        isSaving = true
        errorMessage = nil

        do {
            try await repository.saveQuickNote(
                quickNote.trimmingCharacters(in: .whitespacesAndNewlines)
            )
            quickNote = ""
            await loadRecentFootprints() // 刷新最近足迹
            isSaving = false
            return true
        } catch {
            errorMessage = "保存失败: \(error.localizedDescription)"
            isSaving = false
            return false
        }
    }

    /// 是否可以保存
    var canSave: Bool {
        !quickNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isSaving
    }

    /// 是否有最近足迹
    var hasRecentFootprints: Bool {
        !recentFootprints.isEmpty
    }
}
