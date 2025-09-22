import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            // 1. 맨 위 중앙 제목
            HStack {
                Spacer()
                Text("로그인")
                    .font(.custom("Pretendard-Bold", size: 30))
                Spacer()
            }
            .padding(.top)
            
            Spacer()
                .frame(height: 160)
            
            // 2. 아이디 / 비밀번호
            VStack(alignment: .leading) {
                Text("아이디")
                    .foregroundStyle(.gray)
                Divider()
                    .frame(width: 350, height: 2)
                    .background(Color.gray)
                    .padding(.bottom, 20)
                
                Text("비밀번호")
                    .foregroundStyle(.gray)
                Divider()
                    .frame(width: 350, height: 2)
                    .background(Color.gray)
            }
            
            Spacer()
                .frame(height: 60)
            
            // 3. 로그인 버튼
            Button(action: {
                print("로그인 버튼 클릭")
            }) {
                Text("로그인")
                    .font(.custom("Pretendard-Bold", size: 20))
                    .foregroundStyle(.white)
                    .frame(width: 350, height: 50)
                    .background(Color.purple)
                    .cornerRadius(20)
            }
            
            // 4. 회원가입 텍스트
            Text("회원가입")
                .font(.custom("Pretendard-Medium", size: 15))
                .foregroundStyle(.gray)
                .padding(.top, 2)
            
            // 5. HStack으로 3개의 이미지 버튼 (회원가입 밑 20pt 여백)
            HStack(spacing: 50) {
                Button(action: {
                    print("네이버")
                }) {
                    Image("naver")
                }
                
                Button(action: {
                    print("카카오톡")
                }) {
                    Image("kaka")
                }
                
                Button(action: {
                    print("애플")
                }) {
                    Image("apple")
                }
            }
            .padding(.top, 20) // 회원가입 텍스트 아래 20pt
            Spacer()
            Image("umc")
        }
        .padding(.horizontal)
    }
}

#Preview {
    SplashView()
}


