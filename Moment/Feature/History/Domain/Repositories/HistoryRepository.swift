//
//  HistoryRepository.swift
//  Moment
//
//  历史记录仓储协议
//

import Foundation

/// 历史记录仓储协议
protocol HistoryRepository {
    /// 获取那年今日的记忆
    func getMemoriesOnThisDay() async throws -> [MemoryGroup]
}
