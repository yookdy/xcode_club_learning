//
//  ContentView.swift
//  week2lean
//
//  Created by 육도연 on 9/26/25.
//

//import SwiftUI
//
//struct ContentView: View {
//    @AppStorage("username") private var username: String = "JeOg"
//    
//    var body: some View {
//        VStack {
//            Text("Hello, \(username)!")
//            Button("이름 변경") {
//                username = "UMC"
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI

struct ContentView: View {
    @AppStorage("userAge") private var userAge: Int = 20
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        VStack {
            Text("Age: \(userAge)")
            
            Button(action: {
                userAge += 1
            }, label: {
                Text("나이 증가")
            })
            
            Toggle("Dark Mode", isOn: $isDarkMode)
                .frame(width: 150)
        }
    }
}

#Preview {
    ContentView()
}
