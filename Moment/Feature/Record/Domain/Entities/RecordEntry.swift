//
//  RecordEntry.swift
//  Moment
//
//  记录条目实体
//

import Foundation

/// 记录类型
enum RecordType: String, CaseIterable, Identifiable {
    case note = "写笔记"
    case voice = "语音记录"
    case photo = "拍摄照片"
    case video = "录制视频"

    var id: String { rawValue }

    /// 图标名称
    var iconName: String {
        switch self {
        case .note: return "note.text"
        case .voice: return "mic.fill"
        case .photo: return "camera.fill"
        case .video: return "video.fill"
        }
    }

    /// 背景色名称
    var backgroundColorName: String {
        switch self {
        case .note, .photo: return "SecondaryContainer"
        case .voice, .video: return "SecondaryContainer"
        }
    }
}

/// 快速感悟条目
struct QuickNoteEntry: Identifiable, Equatable {
    let id: String
    let content: String
    let createdAt: Date

    init(
        id: String = UUID().uuidString,
        content: String,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
    }
}
