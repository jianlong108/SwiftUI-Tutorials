//
//  Setting.swift
//  App-Design-and-Layout
//
//  Created by JL on 2025/2/22.
//

import SwiftUI

struct Setting: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: LoginView()) {
                    Image(systemName: "person.crop.circle.badge.questionmark.fill")
                    Text("登录")
                }.frame(height: 40)

                HStack {
                    Image(systemName: "questionmark.circle.fill")
                    Text("关于")
                    Spacer()
                    Image(systemName: "arrow.right")
                }.frame(height: 40)

            }
            .navigationBarTitle(Text("Setting"))
        }
    }
}

#Preview {
    Setting()
}
