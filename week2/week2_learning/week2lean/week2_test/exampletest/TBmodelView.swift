//
//  TBmodelView.swift
//  week2lean
//
//  Created by 육도연 on 9/23/25.
//
//exampl_modelView

import SwiftUI

class TextViewModel: ObservableObject {
    @Published var inputText: String = ""

    init() {
        print("✅ 새로운 TextViewModel 인스턴스 생성됨! ✅")
    }
}

