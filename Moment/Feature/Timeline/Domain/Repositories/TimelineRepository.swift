//
//  TimelineRepository.swift
//  Moment
//
//  时间线仓库接口
//

import Foundation

/// 时间线条目
struct TimelineEntry: Identifiable, Equatable {
    let id: String
    let title: String
    let content: String
    let recordedAt: Date
    let createdAt: Date
    let updatedAt: Date
    let tag: String?
    let thumbnailName: String?

    var hasThumbnail: Bool { thumbnailName != nil }

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
}

/// 时间线仓库协议 - 定义数据操作
protocol TimelineRepository {
    /// 获取指定日期的所有条目
    func entries(for date: Date) async throws -> [TimelineEntry]

    /// 获取最近 N 条记录
    func recentEntries(limit: Int) async throws -> [TimelineEntry]

    /// 保存新条目
    func save(_ entry: TimelineEntry) async throws

    /// 删除条目
    func delete(_ entry: TimelineEntry) async throws

    /// 更新条目
    func update(_ entry: TimelineEntry) async throws
}

/// 时间格式化
extension TimelineEntry {
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: recordedAt)
        if let tag = tag, !tag.isEmpty {
            return "\(timeString) · \(tag)"
        }
        return timeString
    }

    var relativeDateDescription: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(recordedAt) {
            return "今天"
        } else if calendar.isDateInYesterday(recordedAt) {
            return "昨晚"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM月dd日"
            return formatter.string(from: recordedAt)
        }
    }
}

/// 示例数据
extension TimelineEntry {
    static let sampleEntries: [TimelineEntry] = [
        TimelineEntry(
            title: "下午的静谧片刻",
            content: "在街角的咖啡馆，读完了那一本关于时间的书。",
            recordedAt: {
                let d = Date()
                return Calendar.current.date(bySettingHour: 14, minute: 30, second: 0, of: d)!
            }(),
            tag: "咖啡时刻",
            thumbnailName: "photo"
        ),
        TimelineEntry(
            title: "新的项目构思",
            content: "记录了一些关于数字传家宝设计的想法，感觉很有潜力。",
            recordedAt: {
                let d = Date()
                return Calendar.current.date(bySettingHour: 11, minute: 15, second: 0, of: d)!
            }(),
            tag: "灵感"
        ),
        TimelineEntry(
            title: "清晨的公园",
            content: "空气微凉，草地上的露水还没散去。难得的独处时间。",
            recordedAt: {
                let d = Date()
                return Calendar.current.date(bySettingHour: 8, minute: 45, second: 0, of: d)!
            }(),
            tag: "晨间步道",
            thumbnailName: "sun.max"
        ),
        TimelineEntry(
            title: "尝试新菜谱",
            content: "终于成功做了那道复杂的意式烩饭，味道出乎意料的好。",
            recordedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            tag: "晚餐"
        )
    ]
}