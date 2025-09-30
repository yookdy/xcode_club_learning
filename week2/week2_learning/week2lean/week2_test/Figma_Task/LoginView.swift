//
//  LonginView.swift
//  week2lean
//
//  Created by 육도연 on 9/27/25.
//LoginView
//NavigationLink(
//    "프로필 화면으로 이동",
//    destination: Userinfor().environmentObject(user)
////)
//Text(user.username)
//    .font(.title)
//Image("welcome")

import SwiftUI

struct LoginView: View {
    @StateObject var user: LoginViewModel = .init()
    var body: some View {
        
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        // 왼쪽: 텍스트 + 이미지
                        HStack(spacing: 5) {
                            Text(user.username)
                                .font(.title)
                            Image("welcome")
                        }

                        Spacer() // 왼쪽과 오른쪽 띄우기

                        NavigationLink(destination: Userinfor().environmentObject(user)) {
                            Image("memberinfo")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 100)

                    // username과 같은 x값에 맞추기
                    Text("멤버쉽 포인트 500P")
                        .padding(.leading, 16) // HStack 내부 padding과 동일하게 맞춤
                    Button(action: {
                    }) {Image("membership")}
                }
                Image("currinfo")
                HStack(alignment: .center,spacing: 30){
                    Button(action: {
                    }) {Image("Mvticket")}
                    Button(action: {
                    }) {Image("deposit")}
                    Button(action: {
                    }) {Image("specialreservation")}
                    Button(action: {
                    }) {Image("mobileti")}
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
        }
    }
}

#Preview {
    LoginView()
}
