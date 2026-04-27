//
//  HistoryRepositoryImpl.swift
//  Moment
//
//  历史记录仓储实现
//

import Foundation

/// 历史记录仓储实现
final class HistoryRepositoryImpl: HistoryRepository {

    func getMemoriesOnThisDay() async throws -> [MemoryGroup] {
        // 模拟数据 - 实际项目中应从 SwiftData 或网络获取
        let today = Date()

        return [
            MemoryGroup(
                yearsAgo: 1,
                entries: [
                    MemoryEntry(
                        id: UUID(),
                        title: "静谧书咖",
                        content: "在这个早晨，时间仿佛静止。\n去年的今天，我决定放下手机，只身一人在巷口的咖啡店坐了整个上午。原来慢下来，世界如此温柔。",
                        imageURL: nil,
                        videoURL: nil,
                        videoDuration: nil,
                        memoryType: .photo,
                        tags: [],
                        createdAt: Calendar.current.date(byAdding: .year, value: -1, to: today) ?? today,
                        yearsAgo: 1
                    )
                ]
            ),
            MemoryGroup(
                yearsAgo: 3,
                entries: [
                    MemoryEntry(
                        id: UUID(),
                        title: nil,
                        content: "\"真正的成长，不是学会如何抵御风雨，而是学会在雨中起舞。\"\n\n那是那段最困难时期，我写给自己的话。现在回头看，真的挺过来了。",
                        imageURL: nil,
                        videoURL: nil,
                        videoDuration: nil,
                        memoryType: .text,
                        tags: [],
                        createdAt: Calendar.current.date(byAdding: .year, value: -3, to: today) ?? today,
                        yearsAgo: 3
                    ),
                    MemoryEntry(
                        id: UUID(),
                        title: "海边的落日",
                        content: nil,
                        imageURL: nil,
                        videoURL: nil,
                        videoDuration: 45,
                        memoryType: .video,
                        tags: [],
                        createdAt: Calendar.current.date(byAdding: .year, value: -3, to: today) ?? today,
                        yearsAgo: 3
                    )
                ]
            ),
            MemoryGroup(
                yearsAgo: 5,
                entries: [
                    MemoryEntry(
                        id: UUID(),
                        title: "那一年的老友聚会",
                        content: "那时候我们还有大把的时间挥霍，在深夜的街头畅谈理想。虽然现在各奔东西，但这一刻永远定格。",
                        imageURL: nil,
                        videoURL: nil,
                        videoDuration: nil,
                        memoryType: .photo,
                        tags: ["#友情", "#青春", "#上海"],
                        createdAt: Calendar.current.date(byAdding: .year, value: -5, to: today) ?? today,
                        yearsAgo: 5
                    )
                ]
            )
        ]
    }
}
