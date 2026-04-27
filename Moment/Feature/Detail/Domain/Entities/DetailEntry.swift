//
//  DetailEntry.swift
//  Moment
//
//  详情页条目实体
//

import Foundation

/// 详情页条目
struct DetailEntry: Identifiable, Equatable {
    let id: String
    let title: String
    let content: String
    let location: String?
    let tag: String
    let imageURL: URL?
    let voiceURL: URL?
    let voiceDuration: TimeInterval?
    let tags: [String]
    let recordedAt: Date
    let createdAt: Date
    let updatedAt: Date

    /// 相关回忆
    let relatedMemories: [RelatedMemory]

    init(
        id: String = UUID().uuidString,
        title: String,
        content: String,
        location: String? = nil,
        tag: String,
        imageURL: URL? = nil,
        voiceURL: URL? = nil,
        voiceDuration: TimeInterval? = nil,
        tags: [String] = [],
        recordedAt: Date,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        relatedMemories: [RelatedMemory] = []
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.location = location
        self.tag = tag
        self.imageURL = imageURL
        self.voiceURL = voiceURL
        self.voiceDuration = voiceDuration
        self.tags = tags
        self.recordedAt = recordedAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.relatedMemories = relatedMemories
    }
}

/// 相关回忆
struct RelatedMemory: Identifiable, Equatable {
    let id: String
    let title: String
    let imageURL: URL?
    let date: Date

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月"
        return formatter.string(from: date)
    }
}
