//
//  MovieinfoView.swift
//  3weeklean
//
//  Created by 육도연 on 11/17/25.
//
import SwiftUI


/// 메인 뷰 (파일 이름: MovieinfoView.swift)
/// struct 이름: MovieMaininfoView
struct MovieMaininfoView: View {
    /// ViewModel을 @State로 선언
    @State private var viewModel = MovieinfoViewModel() // 이름이 이미 일치함

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading,spacing: 5){
                
                // --- (기존 UI: 로고, 상단 메뉴) ---
                HStack{
                    Image("mega")
                    Spacer()
                }
                HStack(spacing: 10){
                    Button{print("홈 버튼 클릭")} label: { Text("홈").foregroundStyle(Color.black).font(.system(size: 20)).fontWeight(.bold) }
                    Button{print("홈 버튼 클릭")} label: { Text("이벤트").foregroundStyle(Color.black).font(.system(size: 20)).fontWeight(.bold) }
                    Button{print("홈 버튼 클릭")} label: { Text("스토어").foregroundStyle(Color.black).font(.system(size: 20)).fontWeight(.bold) }
                    Button{print("홈 버튼 클릭")} label: { Text("선호극장").foregroundStyle(Color.black).font(.system(size: 20)).fontWeight(.bold) }
                    Spacer()
                }
                HStack{
                    Button(action: { print("상영예정작 버튼 클릭") }) { Text("상영예정").foregroundStyle(Color.white).font(.system(size: 20, weight: .bold)).padding(.vertical, 10).padding(.horizontal, 15).buttonStyle(.glass).background( RoundedRectangle(cornerRadius: 25).fill(Color(white: 0.2)) ) }
                    Button(action: { print("상영예정작 버튼 클릭") }) { Text("무비차트").foregroundStyle(Color.white).font(.system(size: 20, weight: .bold)).padding(.vertical, 10).padding(.horizontal, 15).buttonStyle(.glass).background( RoundedRectangle(cornerRadius: 25).fill(Color(white: 0.7)) ) }
                }
                // --- (기존 UI 끝) ---

                
                // [개선] 로딩 및 에러 상태 처리
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView() // 로딩 중
                        Spacer()
                    }
                    .frame(height: 250)
                } else if let errorMessage = viewModel.errorMessage {
                    HStack { // 에러 메시지 표시
                        Spacer()
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .frame(height: 250)
                } else {
                    // [요청사항] 홈 화면 API 연결
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            // MovieinfoModel 사용
                            ForEach(viewModel.movieModels) { movie in
                                MovieinfoCard(movieInfo: movie)
                            }
                        }
                    }
                    .frame(height: 250)
                }
                
                
                // --- (기존 하단 UI: 피드, 광고 등) ---
                HStack{
                    Text("알고 보면 재미있는 피드").font(.system(size: 20)).bold()
                    Spacer()
                    Button{print("홈 버튼 클릭")} label: { Image(systemName: "arrow.right").foregroundStyle(Color.black) }
                }
                .padding(.top, 10)
                Image("momono")
                    .resizable()
                    .frame(width: 370, height: 240)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        HStack(spacing: 15) {
                            Image("momona1")
                            VStack(alignment: .leading, spacing: 5) {
                                Text("9월, 메가박스 영화들(1)-명작들의 재개봉").font(.headline).fontWeight(.bold)
                                Text("<모노노케 히메>, <퍼펙트 블루>").font(.subheadline).foregroundStyle(Color.secondary)
                            }
                            Spacer()
                        }
                        .padding(.top, 20)
                        HStack(spacing: 15) {
                            Image("face")
                            VStack(alignment: .leading) {
                                Text("메가박스 오리지날 티켓 Re.37<얼굴>").font(.headline).fontWeight(.bold)
                                Text("영화 속 양극적인 대비").font(.subheadline).foregroundStyle(Color.secondary)
                            }
                            Spacer()
                        }
                    }
                }
                // --- (기존 하단 UI 끝) ---
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 20)
        }
        .task {
            //View가 나타날 때(onAppear) 비동기적으로 API 호출
            await viewModel.fetchNowPlayingMovies()
            //영화 데이터를 끌고 오게 만드는 트리거 역활
        }
    }
}

#Preview {
    MovieMaininfoView()
}
