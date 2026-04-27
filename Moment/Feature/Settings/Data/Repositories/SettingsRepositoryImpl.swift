//
//  SettingsRepositoryImpl.swift
//  Moment
//
//  设置仓库实现
//

import Foundation

final class SettingsRepositoryImpl: SettingsRepository {
    private let authRepository: AuthRepository

    init(authRepository: AuthRepository = AuthRepositoryImpl()) {
        self.authRepository = authRepository
    }

    func getCurrentUser() -> SettingsUser? {
        guard let user = authRepository.getCurrentUser() else {
            return nil
        }
        return SettingsUser(from: user)
    }

    func clearAuth() async throws {
        try await authRepository.signOut()
    }
}
