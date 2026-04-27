//
//  GetTimelineEntriesUseCase.swift
//  Moment
//
//  获取时间线条目用例
//

import Foundation

/// 获取时间线条目用例
final class GetTimelineEntriesUseCase {
    private let repository: TimelineRepository

    init(repository: TimelineRepository) {
        self.repository = repository
    }

    /// 执行获取指定日期的条目
    func execute(for date: Date) async throws -> [TimelineEntry] {
        try await repository.entries(for: date)
    }

    /// 执行获取最近条目
    func executeRecent(limit: Int = 20) async throws -> [TimelineEntry] {
        try await repository.recentEntries(limit: limit)
    }
}