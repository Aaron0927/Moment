//
//  AuthRepositoryImpl.swift
//  Moment
//
//  认证仓储实现（临时实现，后续替换为真实后端）
//

import Foundation
import Security

final class AuthRepositoryImpl: AuthRepository {
    // MARK: - Keychain 键
    private enum Keys {
        static let service = "com.moment.app"
        static let currentUser = "currentUser"
    }

    // MARK: - Keychain 操作

    private func saveUserToKeychain(_ user: User) throws {
        let data = try JSONEncoder().encode(user)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Keys.currentUser,
            kSecAttrService as String: Keys.service,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw AuthError.unknown("Keychain save failed: \(status)")
        }
    }

    private func getUserFromKeychain() throws -> User? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Keys.currentUser,
            kSecAttrService as String: Keys.service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecItemNotFound {
            return nil
        }

        guard status == errSecSuccess else {
            throw AuthError.unknown("Keychain read failed: \(status)")
        }

        guard let data = result as? Data else {
            return nil
        }

        return try JSONDecoder().decode(User.self, from: data)
    }

    private func deleteUserFromKeychain() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Keys.currentUser,
            kSecAttrService as String: Keys.service
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            throw AuthError.unknown("Keychain delete failed: \(status)")
        }
    }

    // MARK: - 认证操作

    func signIn(credentials: AuthCredentials) async throws -> User {
        // TODO: 接入真实后端 API
        try await Task.sleep(nanoseconds: 1_000_000_000)

        // 模拟登录成功
        let user = User(
            id: UUID().uuidString,
            email: credentials.identifier.contains("@") ? credentials.identifier : nil,
            phone: !credentials.identifier.contains("@") ? credentials.identifier : nil,
            displayName: "User",
            avatarURL: nil
        )
        try saveUserToKeychain(user)
        return user
    }

    func signUp(email: String, password: String) async throws -> User {
        // TODO: 接入真实后端 API
        try await Task.sleep(nanoseconds: 1_000_000_000)

        let user = User(
            id: UUID().uuidString,
            email: email,
            phone: nil,
            displayName: "New User",
            avatarURL: nil
        )
        try saveUserToKeychain(user)
        return user
    }

    func signInWithApple(idToken: String, nonce: String?) async throws -> User {
        // TODO: 接入 Sign in with Apple
        throw AuthError.unknown("Apple Sign In not implemented")
    }

    func signInWithWeChat(code: String) async throws -> User {
        // TODO: 接入微信登录
        throw AuthError.unknown("WeChat Sign In not implemented")
    }

    func signOut() async throws {
        try deleteUserFromKeychain()
    }

    func getCurrentUser() -> User? {
        try? getUserFromKeychain()
    }
}
