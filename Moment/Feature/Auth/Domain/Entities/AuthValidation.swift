//
//  AuthValidation.swift
//  Moment
//
//  认证验证规则
//

import Foundation

enum AuthValidation {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: emailRegex, options: .regularExpression) != nil
    }

    static func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = #"^\+?[1-9]\d{6,14}$"#
        return phone.range(of: phoneRegex, options: .regularExpression) != nil
    }

    /// 验证密码：最低6位，包括英文和数字
    static func isValidPassword(_ password: String) -> Bool {
        guard password.count >= 6 else { return false }
        let hasLetter = password.range(of: "[A-Za-z]", options: .regularExpression) != nil
        let hasDigit = password.range(of: "[0-9]", options: .regularExpression) != nil
        return hasLetter && hasDigit
    }
}
