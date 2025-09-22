//
//  TicketView.swift
//  Week1_Practice
//
//  Created by 육도연 on 9/20/25.
//
//
//import SwiftUI
//
//struct TicketView: View {
//    var body: some View {
//        ZStack {
//            Image(.background)
//            Spacer().frame(height: 111)
//            mainTitleGroup
//            Spacer().frame(height: 134)
//            mainBottomGroup
//
//        }
//        .padding()
//    }
//    
//    private var mainTitleGroup: some View {
//        VStack {
//            Group {
//                Text("마이펫의 이중생활2")
//                    .font(.custom("Pretendard-Bold", size: 30))
//                    .shadow(color: .black.opacity(1), radius: 6, x: 0, y: 10)
//
//                Text("본인 + 동반 1인")
//                    .font(.custom("Pretendard-Light", size: 16))
//
//                Text("30,100원")
//                    .font(.custom("Pretendard-Bold", size: 24))
//
//            }
//            .foregroundStyle(Color.white)
//        }
//    }
//    private var mainBottomGroup: some View {
//        Button(action: {
//            print("Hello")
//        }, label: {
//            VStack {
//                Image(systemName: "chevron.up")
//                    .resizable()
//                    .frame(width: 18, height: 12)
//                Text("예매하기")
//                    .font(.custom("Pretendard-Bold", size: 30))
//                    .foregroundStyle(Color.white)
//            }
//            .frame(width: 63, height: 40)
//        })
//    }
//}
//
//#Preview {
//    TicketView()
//}
