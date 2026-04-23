//
//  AuthCredentials.swift
//  Moment
//
//  登录凭证
//

import Foundation

struct AuthCredentials: Equatable {
    let identifier: String  // email or phone
    let password: String
}
