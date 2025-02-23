//
//  LoginView.swift
//  App-Design-and-Layout
//
//  Created by JL on 2025/2/22.
//

import SwiftUI

#Preview {
    LoginView()
}

struct LoginView: View {

    @ObservedObject private var viewModel = LoginViewModel()

    var body: some View {

        VStack (alignment: .leading, spacing: 40) {

            //用户名
            VStack {
                RegistrationView(isTextField: true, fieldName: "用户名", fieldValue: $viewModel.username)
                if !viewModel.isUsernameLengthValid {
                    InputErrorView(iconName: "exclamationmark.circle.fill", text: "用户名不合法")
                }

            }
            //密码
            VStack{
                RegistrationView(isTextField: false, fieldName: "密码", fieldValue: $viewModel.password)
                if !viewModel.isPasswordCapitalLetter {
                    InputErrorView(iconName: "exclamationmark.circle.fill", text: "密码以大写字母开头")
                } else if !viewModel.isPasswordLengthValid {
                    InputErrorView(iconName: "exclamationmark.circle.fill", text: "密码不正确")
                } else {}
//                if !viewModel.isPasswordLengthValid && !viewModel.isPasswordCapitalLetter {
//                    InputErrorView(iconName: "exclamationmark.circle.fill", text: viewModel.isPasswordCapitalLetter ? "密码不正确" : "密码需要有一位大写")
//                }
            }
            //再次输入密码
            VStack {
                RegistrationView(isTextField: false, fieldName: "再次输入密码", fieldValue: $viewModel.passwordConfirm)
                if !viewModel.isPasswordConfirmValid {
                    InputErrorView(iconName: "exclamationmark.circle.fill", text: "两次密码需要相同")
                }

            }
            //注册按钮
            Button(action: {}) {
                Text("注册")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            Spacer()
        }.padding()
    }
}

//注册视图
struct RegistrationView: View {
    var isTextField = false
    var fieldName = ""
    @Binding var fieldValue: String
    var body: some View {
        VStack {
            //判断是不是输入框
            if isTextField {
                //输入框
                TextField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.horizontal)
            } else {
                //密码输入框
                SecureField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.horizontal)
            }
            //分割线
            Divider()
                .frame(height: 1)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .padding(.horizontal)
        }
    }
}

//错误判断
struct InputErrorView: View {
    var iconName = ""
    var text = ""
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
            Spacer()
        }.padding(.leading, 10)
    }
}
