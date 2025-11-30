//
//  Userinfo.swift
//  9weeklean
//
//  Created by 육도연 on 11/30/25.
//Userinfor
import SwiftUI
import Combine

struct Userinfor: View {
    @EnvironmentObject var userViewModel: LoginViewModel

    var body: some View {
        VStack {
            // 상단 타이틀 + 네비게이션 버튼
            ZStack {
                Text("회원정보")
                    .font(.largeTitle)

                HStack {
                    NavigationLink(destination:
                        LoginView().environmentObject(userViewModel)) {
                        Image("vector")
                    }
                    Spacer() // 버튼 왼쪽으로 붙이기
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 100)

            // 정보 입력
            VStack(alignment: .leading, spacing: 16) {

                // 이름 입력
                VStack(alignment: .leading, spacing: 4) {
                    TextField("아이디 입력", text: $userViewModel.username)
                        .textFieldStyle(.plain)         // 박스 제거
                        .padding(.vertical, 8)
                    
                    Divider()
                        .background(Color.gray)        // 밑줄
                }

                // ID 입력 + 버튼
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        TextField("아이디 입력", text: $userViewModel.ID)
                            .textFieldStyle(.plain)
                            .padding(.vertical, 8)
                        
                        // 버튼 위치 그대로, 이미지 건드리지 않음
                        Button(action: {
                        }) {
                            Image("change_button")
                        }
                    }
                    
                    Divider()
                        .background(Color.gray)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
    }
}

#Preview {
    Userinfor()
        .environmentObject(LoginViewModel())
}



