//
//  playtest2.swift
//  week2lean
//
//  Created by 육도연 on 9/23/25.
//
import SwiftUI

// 자식 뷰: 스위치 역할
struct SwitchView: View {
    @Binding var isLightOn: Bool

    var body: some View {
        Button(action: {
            isLightOn.toggle()
        }) {
            Text(isLightOn ? "불 끄기" : "불 켜기")//삼항 조건 사용
                .padding()
                .background(isLightOn ? Color.yellow : Color.gray)
                .foregroundColor(.black)
                .cornerRadius(10)
        }
    }
}

// 부모 뷰: 전구 역할
struct LightBulbView: View {
    @State private var isOn: Bool = false

    var body: some View {
        VStack(spacing: 40) {
            Image(systemName: isOn ? "lightbulb.fill" : "lightbulb.slash")
                .font(.system(size: 150))
                .foregroundColor(isOn ? .yellow : .gray)

            SwitchView(isLightOn: $isOn)
        }
    }
}

// 미리보기용 코드
struct LightBulbView_Previews: PreviewProvider {
    static var previews: some View {
        LightBulbView()
    }
}
