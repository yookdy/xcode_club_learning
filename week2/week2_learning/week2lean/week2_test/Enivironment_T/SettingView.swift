//
//  SettingView.swift
//  week2lean
//
//  Created by 육도연 on 9/24/25.
//
/* 자식 뷰(환경 설정 뷰) */
//import SwiftUI
//
//struct SettingsView: View {
//    @EnvironmentObject var userViewModel: UserViewModel2 // 동일한 전역 객체 사용
//
//    var body: some View {
//        VStack {
//            Text("설정 화면")
//                .font(.largeTitle)
//
//            TextField("사용자 이름 변경", text: $userViewModel.username)  // TextField로 직접 변경 가능
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//        }
//    }
//}
//
//#Preview {
//    SettingsView()
//        .environmentObject(UserViewModel2())
//}
