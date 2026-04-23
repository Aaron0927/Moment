//
//  AuthRepository.swift
//  Moment
//
//  认证仓储协议
//

import Foundation

protocol AuthRepository: Sendable {
    func signIn(credentials: AuthCredentials) async throws -> User
    func signUp(email: String, password: String) async throws -> User
    func signInWithApple(idToken: String, nonce: String?) async throws -> User
    func signInWithWeChat(code: String) async throws -> User
    func signOut() async throws
    func getCurrentUser() -> User?
}
