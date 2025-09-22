//
//  UpgradesplashView.swift
//  Week1_Practice
//
//  Created by 육도연 on 9/27/25.
//UpgradeSplashView.swift
import SwiftUI

struct UpgradeSplashView: View {
    @EnvironmentObject var userViewModel: splashViewModel
    @State private var tempID: String = ""
    @State private var tempPassword: String = ""

    var body: some View {
        VStack {
            // 1. 맨 위 중앙 제목
            HStack {
                Spacer()
                Text("로그인")
                    .font(.custom("Pretendard-Bold" , size: 30))
                Spacer()
            }
            .padding(.top)

            // 저장된 값 확인용 (디자인 유지 원하면 이 줄은 지워도 됨)
            Text(userViewModel.ID)

            Spacer()
                .frame(height: 160)

            // 2. 아이디 / 비밀번호 입력
            VStack(alignment: .leading) {
                TextField("아이디 입력", text: $tempID)
                    .textFieldStyle(.plain)
                    .padding(.vertical, 8)
                Divider()
                    .frame(width: 350, height: 2)
                    .background(Color.gray)
                    .padding(.bottom, 20)
                
                TextField("비밀번호 입력", text: $tempPassword)
                    .textFieldStyle(.plain)
                    .padding(.vertical, 8)
                Divider()
                    .frame(width: 350, height: 2)
                    .background(Color.gray)
            }
            
            Spacer()
                .frame(height: 60)

            // 3. 로그인 버튼
            Button(action: {
                userViewModel.ID = tempID
                userViewModel.Password = tempPassword
                print("로그인 버튼 클릭, ID: \(userViewModel.ID), PW: \(userViewModel.Password)")
            }) {
                Text("로그인")
                    .font(.custom("Pretendard-Bold", size: 20))
                    .foregroundStyle(.white)
                    .frame(width: 350, height: 50)
                    .background(Color.purple)
                    .cornerRadius(20)
            }
            
            // 4. 회원가입 텍스트
            Text("회원가입")
                .font(.custom("Pretendard-Medium", size: 15))
                .foregroundStyle(.gray)
                .padding(.top, 2)
            
            // 5. HStack으로 3개의 이미지 버튼
            HStack(spacing: 50) {
                Button(action: { print("네이버") }) { Image("naver") }
                Button(action: { print("카카오톡") }) { Image("kaka") }
                Button(action: { print("애플") }) { Image("apple") }
            }
            .padding(.top, 20)

            Spacer()
            Image("umc")
        }
    }
}


#Preview {
    UpgradeSplashView()
        .environmentObject(splashViewModel())
}

