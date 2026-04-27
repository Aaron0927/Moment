//
//  DetailViewModel.swift
//  Moment
//
//  详情页视图模型
//

import Foundation
import Combine
import SwiftUI

/// 详情页视图模型
@MainActor
final class DetailViewModel: ObservableObject {
    @Published private(set) var entry: DetailEntry?
    @Published private(set) var relatedMemories: [RelatedMemory] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?

    private let repository: DetailRepository

    init(repository: DetailRepository = DetailRepositoryImpl()) {
        self.repository = repository
    }

    /// 加载详情
    func loadDetail(id: String) async {
        isLoading = true
        error = nil

        do {
            entry = try await repository.getDetail(id: id)
            if let entry = entry {
                relatedMemories = try await repository.getRelatedMemories(for: entry)
            }
        } catch {
            self.error = error
        }

        isLoading = false
    }

    /// 格式化记录时间
    func formattedRecordTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月d日 · HH:mm"
        return formatter.string(from: date)
    }

    /// 格式化语音时长
    func formattedVoiceDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
