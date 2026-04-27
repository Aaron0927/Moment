//
//  HistoryViewModel.swift
//  Moment
//
//  那年今日视图模型
//

import Foundation
import Combine

@MainActor
final class HistoryViewModel: ObservableObject {
    @Published private(set) var memoryGroups: [MemoryGroup] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let getMemoriesOnThisDayUseCase: GetMemoriesOnThisDayUseCase

    init(getMemoriesOnThisDayUseCase: GetMemoriesOnThisDayUseCase? = nil) {
        if let useCase = getMemoriesOnThisDayUseCase {
            self.getMemoriesOnThisDayUseCase = useCase
        } else {
            let repository = HistoryRepositoryImpl()
            self.getMemoriesOnThisDayUseCase = GetMemoriesOnThisDayUseCase(repository: repository)
        }
    }

    var isEmpty: Bool {
        memoryGroups.isEmpty
    }

    var currentMonthDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: Date()).uppercased()
    }

    func loadMemories() async {
        isLoading = true
        errorMessage = nil

        do {
            memoryGroups = try await getMemoriesOnThisDayUseCase.execute()
        } catch {
            errorMessage = "加载失败，请重试"
        }

        isLoading = false
    }
}
