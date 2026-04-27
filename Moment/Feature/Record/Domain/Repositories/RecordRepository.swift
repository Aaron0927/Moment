//
//  RecordRepository.swift
//  Moment
//
//  记录仓库接口
//

import Foundation

/// 记录仓库协议
protocol RecordRepository {
    /// 保存快速感悟
    func saveQuickNote(_ content: String) async throws

    /// 获取最近足迹 (最多显示3条)
    func recentFootprints(limit: Int) async throws -> [TimelineEntry]
}
