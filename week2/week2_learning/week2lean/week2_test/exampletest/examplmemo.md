//TopView
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



//exampl_modelView

import SwiftUI

class TextViewModel: ObservableObject {
    @Published var inputText: String = ""

    init() {
        print("✅ 새로운 TextViewModel 인스턴스 생성됨! ✅")
    }
}


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


