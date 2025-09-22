//
//  pretest.swift
//  Week1_Practice
//
//  Created by 육도연 on 9/21/25.
//

import SwiftUI

struct pretest: View {
    @State private var name: String = ""
    var body: some View {
        VStack {
                TextField("이름을 입력하세요", text: $name)
                    .background(Color.blue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Text("입력된 이름: \(name)")
            }
    }
}

#Preview{
    pretest()
}
