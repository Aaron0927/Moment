//
//  RegisterUseCase.swift
//  Moment
//
//  注册用例
//

import Foundation

final class RegisterUseCase: Sendable {
    private let repository: any AuthRepository

    init(repository: any AuthRepository) {
        self.repository = repository
    }

    func execute(email: String, password: String) async throws -> User {
        guard AuthValidation.isValidEmail(email) else {
            throw AuthError.invalidEmail
        }
        guard AuthValidation.isValidPassword(password) else {
            throw AuthError.weakPassword
        }
        return try await repository.signUp(email: email, password: password)
    }
}
