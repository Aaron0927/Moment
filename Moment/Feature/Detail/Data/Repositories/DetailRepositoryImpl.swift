//
//  DetailRepositoryImpl.swift
//  Moment
//
//  详情页仓库实现
//

import Foundation

/// 详情页仓库实现
final class DetailRepositoryImpl: DetailRepository {

    func getDetail(id: String) async throws -> DetailEntry {
        // TODO: 从 SwiftData 或其他数据源获取详情
        // 目前返回示例数据
        return DetailEntry.sampleEntry
    }

    func getRelatedMemories(for entry: DetailEntry) async throws -> [RelatedMemory] {
        // TODO: 根据标签、时间等维度获取相关回忆
        return RelatedMemory.samples
    }
}

// MARK: - 示例数据
extension DetailEntry {
    static let sampleEntry = DetailEntry(
        id: "1",
        title: "苏格兰高地的宁静清晨",
        content: """
        清晨的雾气还未散去，整个老人峰都被笼罩在一层轻柔的蓝调之中。那一刻，耳边只有风声和偶尔传来的鸟鸣。

        这里的空气带着一种清冽的泥土芬芳，让人不不由自主地深呼吸。我们沿着泥泞的小径向上攀登，每一步都仿佛在与大自然进行一场跨越时空的对话。

        生活的真谛也许并不在于抵达终点，而是在于这些微小、寂静且直击心灵的瞬间。这些记忆，像是一份珍贵的传家宝，在心底慢慢沉淀。
        """,
        location: "Isle of Skye, Scotland",
        tag: "旅行",
        imageURL: nil,
        voiceURL: nil,
        voiceDuration: 165,
        tags: ["宁静", "大自然"],
        recordedAt: {
            var components = DateComponents()
            components.year = 2023
            components.month = 10
            components.day = 12
            components.hour = 6
            components.minute = 30
            return Calendar.current.date(from: components)!
        }(),
        createdAt: Date(),
        updatedAt: Date(),
        relatedMemories: RelatedMemory.samples
    )
}

extension RelatedMemory {
    static let samples: [RelatedMemory] = [
        RelatedMemory(
            id: "2",
            title: "迷雾森林",
            imageURL: nil,
            date: {
                var components = DateComponents()
                components.year = 2023
                components.month = 9
                components.day = 15
                return Calendar.current.date(from: components)!
            }()
        ),
        RelatedMemory(
            id: "3",
            title: "落日余晖",
            imageURL: nil,
            date: {
                var components = DateComponents()
                components.year = 2023
                components.month = 8
                components.day = 20
                return Calendar.current.date(from: components)!
            }()
        ),
        RelatedMemory(
            id: "4",
            title: "夏日原野",
            imageURL: nil,
            date: {
                var components = DateComponents()
                components.year = 2023
                components.month = 7
                components.day = 10
                return Calendar.current.date(from: components)!
            }()
        )
    ]
}
