//
//  MemoryEntry.swift
//  Moment
//
//  记忆条目实体
//

import Foundation

/// 记忆类型
enum MemoryType {
    case photo
    case text
    case video
}

/// 记忆条目
struct MemoryEntry: Identifiable {
    let id: UUID
    let title: String?
    let content: String?
    let imageURL: URL?
    let videoURL: URL?
    let videoDuration: TimeInterval?
    let memoryType: MemoryType
    let tags: [String]
    let createdAt: Date
    let yearsAgo: Int

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: createdAt)
    }

    var yearLabel: String {
        "\(yearsAgo)年前的今天"
    }

    var displayTitle: String {
        title ?? ""
    }

    var displayContent: String {
        content ?? ""
    }
}

/// 那年今日分组
struct MemoryGroup: Identifiable {
    let id = UUID()
    let yearsAgo: Int
    let entries: [MemoryEntry]

    var yearLabel: String {
        "\(yearsAgo)年前的今天"
    }
}
