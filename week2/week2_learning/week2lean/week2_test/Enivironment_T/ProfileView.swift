//
//  profileView.swift
//  week2lean
//
//  Created by 육도연 on 9/24/25.
//
/* 자식 뷰(프로필 뷰) */
//import SwiftUI
//
//struct ProfileView: View {
//    @EnvironmentObject var userViewModel: UserViewModel2  // 부모 뷰에서 전달된 환경 객체 사용
//
//    var body: some View {
//        VStack {
//            Text("프로필 화면")
//                .font(.largeTitle)
//
//            Text("사용자 이름: \(userViewModel.username)")  // 부모 뷰의 상태가 자동 반영됨
//                .font(.title)
//
//            Button("이름 변경") {
//                userViewModel.username = "새로운 사용자"  // 값이 변경되면 모든 뷰에 즉시 반영
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundStyle(.white)
//        }
//    }
//}
//
//#Preview {
//    ProfileView()
//        .environmentObject(UserViewModel2())
//}

