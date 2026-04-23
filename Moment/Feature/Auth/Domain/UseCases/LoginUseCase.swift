//
//  LoginUseCase.swift
//  Moment
//
//  登录用例
//

import Foundation

final class LoginUseCase: Sendable {
    private let repository: any AuthRepository

    init(repository: any AuthRepository) {
        self.repository = repository
    }

    func execute(credentials: AuthCredentials) async throws -> User {
        guard !credentials.identifier.isEmpty else {
            throw AuthError.invalidIdentifier
        }
        guard !credentials.password.isEmpty else {
            throw AuthError.invalidPassword
        }
        return try await repository.signIn(credentials: credentials)
    }
}
