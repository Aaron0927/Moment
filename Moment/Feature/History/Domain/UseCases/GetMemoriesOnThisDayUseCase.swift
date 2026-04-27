//
//  GetMemoriesOnThisDayUseCase.swift
//  Moment
//
//  获取那年今日记忆用例
//

import Foundation

/// 获取那年今日记忆用例
final class GetMemoriesOnThisDayUseCase {
    private let repository: HistoryRepository

    init(repository: HistoryRepository) {
        self.repository = repository
    }

    func execute() async throws -> [MemoryGroup] {
        try await repository.getMemoriesOnThisDay()
    }
}
