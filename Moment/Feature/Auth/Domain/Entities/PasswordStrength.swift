//
//  PasswordStrength.swift
//  Moment
//
//  密码强度评估
//

import SwiftUI

enum PasswordStrength: CaseIterable {
    case weak
    case medium
    case strong

    var color: Color {
        switch self {
        case .weak: return Color.themeError
        case .medium: return Color.themePrimary
        case .strong: return Color.themeSecondary
        }
    }

    var label: String {
        switch self {
        case .weak: return "Weak"
        case .medium: return "Medium"
        case .strong: return "Strong"
        }
    }

    static func evaluate(_ password: String) -> PasswordStrength {
        guard password.count >= 6 else { return .weak }

        let hasLetter = password.range(of: "[A-Za-z]", options: .regularExpression) != nil
        let hasDigit = password.range(of: "[0-9]", options: .regularExpression) != nil

        guard hasLetter && hasDigit else { return .weak }

        let hasSpecial = password.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil

        if hasSpecial || password.count >= 10 {
            return .strong
        }
        return .medium
    }
}