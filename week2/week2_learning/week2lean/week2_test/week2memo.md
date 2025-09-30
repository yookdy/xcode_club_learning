#1.UserView에서 사용자 클릭
#2.클릭의 변화의 해당되는 함수 기능을 찾아감
#3.UserModel에서의 해당함수에 기능 실행
#4.변화를 UserViewModel를 통해서 UserView에 전달
#5.UI에서 변화




#@State
//State 기본적으로 UI에서 변하면 바로 반영하는 개념?

import SwiftUI

struct ContentView: View {
    @State private var count = 0  // 상태 프로퍼티 선언

    var body: some View {
        VStack {
            Text("카운트: \(count)") // 값이 변경되면 자동 업데이트
                .font(.largeTitle)

            Button("증가") {
                count += 1  // 상태 변경 시 UI 자동 업데이트
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}



#@Binding
@Binding은 SwiftUI에서 부모 뷰가 가진 상태(@State)를 자식 뷰와 공유하고, 자식 뷰에서 그 상태를 직접 수정할 수 있도록 연결해주는 강력한 프로퍼티 래퍼입니다. 
구분                               @State                         @Binding
데이터 소유      뷰가 직접 데이터를 소유하고 관리 (데이터의 원천)[3]    다른 뷰가 소유한 데이터를 참조 (데이터를 직접 소유하지 않음)[3]
역할           뷰 내부의 상태를 저장하고 변경을 감지                다른 뷰의 상태를 읽고 수정할 수 있는 연결 통로
초기값          반드시 초기값이 필요함                           초기값이 필요 없으며, 외부에서 전달받음[3]
사용 위치       주로 부모 뷰 또는 데이터를 소유해야 하는 뷰           부모 뷰의 데이터를 사용하고 수정해야 하는 자식 뷰
@State는 데이터의 "주인"이고 @Binding은 그 주인이 가진 데이터에 접근할 수 있는 "열쇠"라고 비유할 수 있습니다.

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

- **뷰 단위의 제한적인 상태 관리**
    - `@State`는 개별 뷰 내부에서만 사용되므로, 여러 뷰에서 동일한 상태를 공유해야 할 때 적절하지 않습니다.
    - 상태를 공유하려면 `@Binding`을 사용해야 하지만, **뷰 계층이 복잡해질수록 바인딩을 계속 전달해야 하는 문제가 발생합니다.**
- **데이터의 중앙 집중적 관리 어려움**
    - 앱의 중요한 상태(로그인, 네트워크 받아온 데이터 등)을 유지하려면, `@State` 만으로는 데이터를 효율적으로 관리하기 어렵습니다.
    - 여러 뷰에서 같은 데이터를 사용해야 할 경우, 각각의 뷰에 동일한 `@State` 변수를 만들어야 하므로 코드 중복이 발생합니다.
- **뷰가 상태를 직접 관리하므로 뷰가 아닌 다른 곳에서 상태를 관리하기 어려움**--객체가 직접적으로 관리함
    - 상태 프로퍼티는 **뷰 내부에서 직접 관리**되므로, 뷰(View)와 데이터(Model)를 분리하는 MVVM(Model-View-ViewModel)이나 단방향 흐름 아키텍처를 적용하기 어렵습니다.





#ObservableObject---외부에서 빌려온거 직접적으로 UI 생성X
Observable 객체는 뷰가 직접 상태를 관리하는 것이 아니라, 상태를 따로 관리하는 객체를 만들고 그 변화를 감지하여 UI를 자동으로 갱신하는 방식을 사용합니다.
----->여러 객체를 만들고 각각의 객체가 관리해줌
----->Published를 이용해서 조장 역활, ObservableObject는 조원 연결 해줌
#P
- **@ObservedObject는 객체의 생명 주기를 직접 관리하지 않습니다.**
    
    > @ObservedObject는 상위 뷰에서 전달받은 ObservableObject를 구독할 수는 있지만,
    > 
    > 
    > 뷰가 새로 생성될 때마다 **새로운 인스턴스를 참조할 가능성이 있습니다.**
    > 
    > 즉, 뷰가 다시 렌더링될 때 기존의 ObservableObject 인스턴스를 유지하는 것이 아니라,
    > 
    > **새로운 객체를 참조할 가능성이 있어 기존 상태가 초기화될 위험이 존재합니다.**
    >
#StateObject 직접적으로 UI를 생성하고 보여줌
@StateObject는 뷰의 생명 주기 동안 객체를 유지하며, 뷰가 다시 생성될 때도 새로운 객체를 만들지 않고 기존 객체를 유지합니다
@StateObject의 규칙
@StateObject는 뷰가 처음 생성될 때 단 한 번만 객체를 초기화합니다.
#. 
StateObject.                                ObservableObject
해당 객체를 해당 뷰의 생명 주기 동안 유지             부모 뷰에서 생성된 ObservableObject를 하위 뷰에서 사용해야 할 때
-**뷰가 다시 생성되더라도 기존 상태를 유지해야 할 때**   -**객체의 생명 주기를 직접 관리하고 싶을 때**
    - 네트워크 요청 상태를 유지해야 하는 경우              - ObservableObject가 특정 뷰에 의존하지 않고, 앱 전반에서 사용될 경우                            
                                            
                                            
                                            
/* 뷰모델 */
import SwiftUI

class TextViewModel: ObservableObject {
    @Published var inputText: String = ""

    init() {
        print("✅ 새로운 TextViewModel 인스턴스 생성됨! ✅")
    }
}

* 상위 뷰 */

import SwiftUI

struct TopView: View {
    @StateObject var viewModel: TextViewModel = .init()
    @State private var showBottomView = false

    var body: some View {
        NavigationStack {
            VStack {
                
                Text("상위뷰입니다.")
                Text("텍스트 입력 값 : \(viewModel.inputText)")
                TextField("아무런 값을 넣어보세요!", text: $viewModel.inputText)
                    .frame(width: 350)
                
                Button("하위뷰 부르기") {
                    showBottomView.toggle()
                }
                .sheet(isPresented: $showBottomView) {
                    BottomView(viewModel: viewModel)
                }
            }
        }
    }
}

#Preview {
    TopView()
}
#문제 발생
init() 안에서 초기화----------Preview의 논리와 충돌하는 문제 발생,init은 직접 생성하는 생성해서 Preview의 파일의 생성 담당과 충돌하는 문제 발생
----->SwiftUI Preview는 뷰를 여러 번 "재생성"하면서 상태 변화를 추적합니다.
      그런데 @StateObject는 "뷰가 생성될 때 딱 한 번"만 초기화되어야 하죠.
      Preview가 반복해서 뷰를 생성하면서도 init() 안에서 StateObject를 강제로 새로 만들면 → SwiftUI의 규칙과 어긋나서 충돌 발생 ❌
--------->@Published → objectWillChange → Combine 퍼블리셔 → SwiftUI 뷰 리렌더링



------------>기존의 방식에서는 StateObject를 통해 뷰가 뷰모델의 수명을 책임지게 하고, ObservedObject를 통해 자식 뷰에게 전달했습니다.
#@Observable
------------>Observation 트래킹 → SwiftUI 직접 리렌더링, Bindable은 @Observable에서만 쓰일 수 있음
-------->Bindable은 Bindin하고 같은 역활을 함----사용되는 의미가 확장이 됨
/* viewModel */

import Foundation

@Observable
class CounterViewModel {
    var count = 0
}

/* View */

import SwiftUI

struct ContentView: View {
    
    var viewModel: CounterViewModel = .init()
    
    var body: some View {
        VStack {
            
            Text("\(viewModel.count)")
            
            Button(action: {
                viewModel.count += 1
            }, label: {
                Text("카운트 증가합니다.")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
`@Observable` 을 사용하기 위해서는 `import Observation`을 꼭 해야합니다.
근데 위 코드에는 하지 않았죠 왜일까요?! 

`Foundation` 프레임워크에 `Observation`이 포함되어 있기 때문입니다!


#Environment
디자인적 요소들을 부모뷰(메인 뷰)의 있는요소를 다른 환경에서도 적용하게하는 역활을 함 Binding은 일일히 보내지만 Environment는 한번에 설정 가능함


#@EnvironmentObject
ObservableObject를 사용하여 전역적인 데이터를 공유할 때 사용하는 속성 래퍼입니다.
위의 개념과 비슷하게 데이터를 전역으로 관리함

#Preview {
    SettingsView()
        .environmentObject(UserViewModel())
}
@EnvironmentObject를 사용하는 뷰를 미리보기 하려면 반드시 .environmentObject()를 통해 객체를 전달해 주어야 합니다.


#Observation
@State로 설정을 넣고 Environment로 설정을 해서 전역으로 사용하게 만듦

#@AppStorage
@AppStorage란 SwiftUI에서 제공하는 속성 래퍼로, UserDefaults 를 간편하게 사용할 수 있도록 도와줍니다.
SwiftUI의 State나 StateObject와 유사하게 동작하면서도, 데이터를 앱의 영구 저장소(UserDefaults)에 저장하여 앱을 종료하고 다시 실행해도 값을 유지할 수 있도록 합니다.
--->UserDefault는 간단한 저장소로 소량의 정보를 저장해 주는 역활을 함


let defaults = UserDefaults.standard

// 기본 자료형 데이터 저장하기
defaults.set(true, forKey: "isLoggedIn")   // Bool 값 저장
defaults.set(25, forKey: "userAge")        // Int 값 저장
defaults.set("John", forKey: "username")   // String 값 저장

// 배열과 딕셔너리 저장하기
defaults.set(["Apple", "Banana", "Orange"], forKey: "fruits")
defaults.set(["name": "John", "age": 25], forKey: "userDetails")

import SwiftUI

struct ContentView: View {
    @AppStorage("username") private var username: String = "JeOg"
    
    var body: some View {
        VStack {
            Text("Hello, \(username)!")
            Button("이름 변경") {
                username = "UMC"
            }
        }
    }
}

#Preview {
    ContentView()
}
저장소에 이름이 저장되어있느상태
지원 타입    예제
           @AppStorage("변수명") var name: (형태) = "Default"
String    @AppStorage("name()") var name: String = "Default"
Int    @AppStorage("score") var score: Int = 0
Double    @AppStorage("volume") var volume: Double = 0.5
Bool    @AppStorage("isDarkMode") var isDarkMode: Bool = false
Data    @AppStorage("userData") var userData: Data?
> @AppStorage는 **앱의 설정 값**을 저장할 때 유용합니다.
> 자동적으로 동기화해주기는 Userdefault는 자동적으로 동기화가 안됨
- 다크 모드 설정
- 자동 로그인 여부
- 마지막 접속한 사용자
- 앱 테마 색상
- 유저 이름 닉네임 정보


#Extra
#보안이 필요한 데이터는 Keychain, xcconfig


#OnAppear
생명주기를 온 하는 기능을 가짐
- **불필요한 네트워크 요청 지속 문제**
    - 사용자가 뷰를 빠르게 이동할 경우, **여러 개의 네트워크 요청이 동시에 실행**
    - **응답을 받을 필요가 없는 요청이 계속 남아있으면 CPU 사용량 증가**
- **메모리 누수**
    - onAppear에서 실행된 비동기 작업이 뷰의 @State 변수를 캡처하면, 해당 뷰가 사라져도 메모리에 남아 있을 가능성
    - 네트워크 요청이 완료될 때까지 뷰가 해제되지 않으면 **메모리 누수**가 발생
- **백그라운드 불필요한 작업 실행**
    - 뷰가 화면에서 사라졌음에도 불구하고, 실행중인 Task가 백그라운드에서 계속 실행
    - 즉, 뷰가 존재하지 않아도 작업이 끝날 때까지 CPU 지속적으로 사용
    
#onDisappear

