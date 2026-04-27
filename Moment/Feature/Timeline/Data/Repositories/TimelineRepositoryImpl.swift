//
//  TimelineRepositoryImpl.swift
//  Moment
//
//  SwiftData 时间线仓库实现
//

import Foundation
import SwiftData

@MainActor
final class TimelineRepositoryImpl: TimelineRepository {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func entries(for date: Date) async throws -> [TimelineEntry] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        let predicate = #Predicate<TimelineEntryModel> { entry in
            entry.recordedAt >= startOfDay && entry.recordedAt < endOfDay
        }

        let descriptor = FetchDescriptor<TimelineEntryModel>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.recordedAt, order: .reverse)]
        )

        let models = try modelContext.fetch(descriptor)
        return models.map { $0.toTimelineEntry() }
    }

    func recentEntries(limit: Int) async throws -> [TimelineEntry] {
        var descriptor = FetchDescriptor<TimelineEntryModel>(
            sortBy: [SortDescriptor(\.recordedAt, order: .reverse)]
        )
        descriptor.fetchLimit = limit

        let models = try modelContext.fetch(descriptor)
        return models.map { $0.toTimelineEntry() }
    }

    func save(_ entry: TimelineEntry) async throws {
        let model = TimelineEntryModel(from: entry)
        modelContext.insert(model)
        try modelContext.save()
    }

    func delete(_ entry: TimelineEntry) async throws {
        let entryId = entry.id
        let predicate = #Predicate<TimelineEntryModel> { $0.id == entryId }
        let descriptor = FetchDescriptor<TimelineEntryModel>(predicate: predicate)

        if let model = try modelContext.fetch(descriptor).first {
            modelContext.delete(model)
            try modelContext.save()
        }
    }

    func update(_ entry: TimelineEntry) async throws {
        let entryId = entry.id
        let predicate = #Predicate<TimelineEntryModel> { $0.id == entryId }
        let descriptor = FetchDescriptor<TimelineEntryModel>(predicate: predicate)

        if let model = try modelContext.fetch(descriptor).first {
            model.title = entry.title
            model.content = entry.content
            model.recordedAt = entry.recordedAt
            model.updatedAt = Date()
            model.tag = entry.tag
            model.thumbnailName = entry.thumbnailName
            try modelContext.save()
        }
    }
}

// MARK: - SwiftData 模型

@Model
final class TimelineEntryModel {
    var id: String
    var title: String
    var content: String
    var recordedAt: Date
    var createdAt: Date
    var updatedAt: Date
    var tag: String?
    var thumbnailName: String?

    init(
        id: String = UUID().uuidString,
        title: String,
        content: String,
        recordedAt: Date,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        tag: String? = nil,
        thumbnailName: String? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.recordedAt = recordedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.tag = tag
        self.thumbnailName = thumbnailName
    }

    convenience init(from entry: TimelineEntry) {
        self.init(
            id: entry.id,
            title: entry.title,
            content: entry.content,
            recordedAt: entry.recordedAt,
            createdAt: entry.createdAt,
            updatedAt: entry.updatedAt,
            tag: entry.tag,
            thumbnailName: entry.thumbnailName
        )
    }

    func toTimelineEntry() -> TimelineEntry {
        TimelineEntry(
            id: id,
            title: title,
            content: content,
            recordedAt: recordedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            tag: tag,
            thumbnailName: thumbnailName
        )
    }
}