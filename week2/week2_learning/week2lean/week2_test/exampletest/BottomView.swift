//
//  BottomView.swift
//  week2lean
//
//  Created by 육도연 on 9/23/25.
//
// BottomView
import SwiftUI

struct BottomView: View {
    @ObservedObject var viewModel: TextViewModel
    
    init(viewModel: TextViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text("하위 뷰 입니다.")
            Text("현재 입력된 값 : \(viewModel.inputText)")
            Button("강제 초기화") {
                viewModel.inputText = "초기화됨"
            }
            Spacer()
        }
    }
}
