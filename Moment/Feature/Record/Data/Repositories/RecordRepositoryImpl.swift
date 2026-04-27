//
//  RecordRepositoryImpl.swift
//  Moment
//
//  记录仓库实现
//

import Foundation
import SwiftData

@MainActor
final class RecordRepositoryImpl: RecordRepository {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func saveQuickNote(_ content: String) async throws {
        let entry = TimelineEntry(
            title: "快速感悟",
            content: content,
            recordedAt: Date()
        )
        let model = TimelineEntryModel(from: entry)
        modelContext.insert(model)
        try modelContext.save()
    }

    func recentFootprints(limit: Int) async throws -> [TimelineEntry] {
        var descriptor = FetchDescriptor<TimelineEntryModel>(
            sortBy: [SortDescriptor(\.recordedAt, order: .reverse)]
        )
        descriptor.fetchLimit = limit

        let models = try modelContext.fetch(descriptor)
        return models.map { $0.toTimelineEntry() }
    }
}
