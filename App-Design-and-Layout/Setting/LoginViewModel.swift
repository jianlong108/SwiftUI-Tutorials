//
//  LoginViewModel.swift
//  App-Design-and-Layout
//
//  Created by JL on 2025/2/22.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {

    // 输入
    @Published var username = ""
    @Published var password = ""
    @Published var passwordConfirm = ""

    // 输出
    @Published var isUsernameLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false

    private var cancelableSet: Set<AnyCancellable> = []

    init() {
        $username
            .receive(on: RunLoop.main)
            .print("username")
            .map { username in
                username.count > 2
            }
            .assign(to: \.isUsernameLengthValid, on: self)
            .store(in: &cancelableSet)
        $password
            .receive(on: RunLoop.main)
            .print("passwordLengt")
            .map { password in
                password.count >= 6
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancelableSet)
        $password
            .receive(on: RunLoop.main)
            .map { password in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .print("passwordCapital")
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancelableSet)
        Publishers.CombineLatest($password, $passwordConfirm).receive(on: RunLoop.main)
            .map { password, passwordConfirm in
                !password.isEmpty && !passwordConfirm.isEmpty && (password == passwordConfirm)
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancelableSet)
    }
}
