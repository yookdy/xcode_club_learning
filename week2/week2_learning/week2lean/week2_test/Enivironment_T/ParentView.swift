//
//  ParentView.swift
//  week2lean
//
//  Created by 육도연 on 9/24/25.
//
/* 부모 뷰 */
//import SwiftUI
//
//struct ParentView: View {
//    @StateObject var userViewModel: UserViewModel2 = .init()
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("현재 사용자: \(userViewModel.username)")
//                    .font(.title)
//
//                NavigationLink(
//                    "프로필 화면으로 이동",
//                    destination: ProfileView().environmentObject(userViewModel)
//                )
//                NavigationLink("설정 화면으로 이동",
//                               destination: SettingsView().environmentObject(userViewModel)
//                )
//            }
//            
//        }
//    }
//}
//
//#Preview {
//    ParentView()
//}
