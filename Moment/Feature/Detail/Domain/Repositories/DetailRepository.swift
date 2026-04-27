//
//  DetailRepository.swift
//  Moment
//
//  详情页仓库接口
//

import Foundation

/// 详情页仓库协议
protocol DetailRepository {
    /// 获取详情
    func getDetail(id: String) async throws -> DetailEntry

    /// 获取相关回忆
    func getRelatedMemories(for entry: DetailEntry) async throws -> [RelatedMemory]
}
