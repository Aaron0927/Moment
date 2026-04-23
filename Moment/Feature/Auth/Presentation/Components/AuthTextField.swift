//
//  AuthTextField.swift
//  Moment
//
//  认证表单输入框组件
//

import SwiftUI

struct AuthTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    var isPasswordVisible: Bool = false
    var onTogglePasswordVisibility: (() -> Void)?

    var body: some View {
        HStack(spacing: 12) {
            Group {
                if isSecure && !isPasswordVisible {
                    SecureField(placeholder, text: $text)
                        .frame(height: 20)
                } else {
                    TextField(placeholder, text: $text)
                        .frame(height: 20)
                }
            }
            .font(.system(size: 14))
            .foregroundStyle(Color.themeOnSurfaceVariant)
            .keyboardType(keyboardType)
            .textContentType(keyboardType == .emailAddress ? .emailAddress : .none)
            .autocapitalization(.none)
            .disableAutocorrection(true)

            if isSecure {
                Button(action: { onTogglePasswordVisibility?() }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.themeOnSurfaceVariant)
                }
                .padding(.trailing, 12)
            }
        }
        .padding(.horizontal, 17)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: RoundedCorner.default)
                .fill(Color.themeBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: RoundedCorner.default)
                        .stroke(Color.themeSurfaceVariant, lineWidth: 1)
                )
        )
    }
}

// MARK: - Email 输入框

struct AuthEmailField: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .font(.system(size: 14))
            .foregroundStyle(Color.themeOnSurfaceVariant)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.horizontal, 17)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: RoundedCorner.default)
                    .fill(Color.themeBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: RoundedCorner.default)
                            .stroke(Color.themeSurfaceVariant, lineWidth: 1)
                    )
            )
    }
}

#Preview {
    VStack(spacing: 20) {
        AuthTextField(
            placeholder: "Email or Phone",
            text: .constant("")
        )

        AuthTextField(
            placeholder: "Password",
            text: .constant(""),
            isSecure: true,
            isPasswordVisible: false
        )

        AuthEmailField(
            placeholder: "Email",
            text: .constant("")
        )
    }
    .padding()
    .background(Color.themeBackground)
}