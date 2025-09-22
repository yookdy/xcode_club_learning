//
//  Week1_PracticeApp.swift
//  Week1_Practice
//
//  Created by 육도연 on 9/20/25.
//

//import SwiftUI
//
//@main
//struct Week1_PracticeApp: App {
//    var body: some Scene {
//        WindowGroup {
//            //SplashView()
//            UpgradeSplashView()
//        }
//    }
//}
//Week1_PracticeApp에서 환경 객체 주입

import SwiftUI

@main
struct Week1_PracticeApp: App {
    @StateObject var userViewModel = splashViewModel() // ✅ 뷰모델 생성

    var body: some Scene {
        WindowGroup {
            UpgradeSplashView()
                .environmentObject(userViewModel) // ✅ 환경 객체로 주입
        }
    }
}
//즉, 환경 객체를 전달하지 않은 상태에서 사용했기 때문에 실행 중에 SwiftUI가
//"splashViewModel 못 찾겠는데요?"
//라고 하면서 Fatal error: No ObservableObject of type splashViewModel found 에러가 터진 거예요.

//------------>
//문제: @EnvironmentObject는 반드시 부모에서 .environmentObject(...)로 전달받아야 하는데, 안 해줘서 뷰에서 못 찾음 → 런타임 에러 발생.
//해결: 앱 시작점에서 splashViewModel을 @StateObject로 만들고, .environmentObject(...)로 주입해줌.
