//
//  practicalMainView.swift
//  3weeklean
//
//  Created by 육도연 on 10/4/25.
//

//MovieMainView.swift

import SwiftUI

struct MovieMainView: View {
    @State private var viewModel = MovieViewModel()

    var body: some View {
        NavigationStack {  // ← 여기 추가
            VStack(alignment: .leading,spacing: 5){
                HStack{
                    Image("mega")
                    Spacer()
                }
                HStack(spacing: 10){
                    Button{print("홈 버튼 클릭")}
                    label: {
                        Text("홈")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                    Button{print("홈 버튼 클릭")}
                    label: {
                        Text("이벤트")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                    Button{print("홈 버튼 클릭")}
                    label: {
                        Text("스토어")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                    Button{print("홈 버튼 클릭")}
                    label: {
                        Text("선호극장")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                HStack{
                    Button(action: {
                        print("상영예정작 버튼 클릭")
                    }) {
                        Text("상영예정")
                            .foregroundStyle(Color.white)                   // 글자색 흰색
                            .font(.system(size: 20, weight: .bold))    // 폰트 크기 & 두께
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .buttonStyle(.glass)
                            .background(                                // 글자 아래 배경
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color(white: 0.2))           // 어두운 회색 배경
                            )
                    }
                    Button(action: {
                        print("상영예정작 버튼 클릭")
                    }) {
                        Text("무비차트")
                            .foregroundStyle(Color.white)                   // 글자색 흰색
                            .font(.system(size: 20, weight: .bold))    // 폰트 크기 & 두께
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .buttonStyle(.glass)
                            .background(                                // 글자 아래 배경
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color(white: 0.7))           // 어두운 회색 배경
                            )
                    }
                }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 5) {
                            ForEach(viewModel.movieModel.indices, id: \.self) { index in
                                MovieCard(movieInfo: viewModel.movieModel[index]) // MovieCard 내부에서 NavigationLink 적용
                            }
                        }
                    }
                    .frame(height: 250)
                HStack{
                    Text("알고 보면 재미있는 피드")
                        .font(.system(size: 20))
                        .bold()
                    Spacer()
                    Button{print("홈 버튼 클릭")}
                    label: {
                        Image(systemName: "arrow.right")
                            .foregroundStyle(Color.black)
                        }
                    }
                .padding(.top, 10)
                Image("momono")
                    .resizable() //필수! 이미지 크기를 조절할 수 있게 함
                    .frame(width: 370, height: 240)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        HStack(spacing: 15) {
                            Image("momona1")
                            VStack(alignment: .leading, spacing: 5) {
                                Text("9월, 메가박스 영화들(1)-명작들의 재개봉")
                                    .font(.headline)
                                    .fontWeight(.bold)

                                Text("<모노노케 히메>, <퍼펙트 블루>")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.secondary)
                            }
                            Spacer()
                        }
                        .padding(.top, 20)

                        // 새로운 항목 추가
                        HStack(spacing: 15) {
                            Image("face")
                            VStack(alignment: .leading) {
                                Text("메가박스 오리지날 티켓 Re.37<얼굴>")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Text("영화 속 양극적인 대비")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.secondary)
                            }
                            Spacer()
                        }
                    }
                    }
                }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 20)
            }
        }
    }


#Preview {
    MovieMainView()
}

//import SwiftUI
//
//struct MovieMainView: View {
//    @State private var viewModel = MovieViewModel()
//
//    var body: some View {
//        VStack{
//            VStack(alignment: .leading,spacing: 5){
//                HStack{
//                    Image("mega")
//                    Spacer()
//                }
//                HStack(spacing: 10){
//                    Button{print("홈 버튼 클릭")}
//                    label: {
//                        Text("홈")
//                            .foregroundStyle(Color.black)
//                            .font(.system(size: 20))
//                            .fontWeight(.bold)
//                    }
//                    Button{print("홈 버튼 클릭")}
//                    label: {
//                        Text("이벤트")
//                            .foregroundStyle(Color.black)
//                            .font(.system(size: 20))
//                            .fontWeight(.bold)
//                    }
//                    Button{print("홈 버튼 클릭")}
//                    label: {
//                        Text("스토어")
//                            .foregroundStyle(Color.black)
//                            .font(.system(size: 20))
//                            .fontWeight(.bold)
//                    }
//                    Button{print("홈 버튼 클릭")}
//                    label: {
//                        Text("선호극장")
//                            .foregroundStyle(Color.black)
//                            .font(.system(size: 20))
//                            .fontWeight(.bold)
//                    }
//                    Spacer()
//                }
//                HStack{
//                    Button(action: {
//                        print("상영예정작 버튼 클릭")
//                    }) {
//                        Text("무비차트")
//                            .foregroundColor(.white)                   // 글자색 흰색
//                            .font(.system(size: 20, weight: .bold))    // 폰트 크기 & 두께
//                            .padding(.vertical, 10)
//                            .padding(.horizontal, 15)
//                            .background(                                // 글자 아래 배경
//                                RoundedRectangle(cornerRadius: 25)
//                                    .fill(Color(white: 0.2))           // 어두운 회색 배경
//                            )
//                    }
//                    .cornerRadius(25)
//                    Button(action: {
//                        print("상영예정작 버튼 클릭")
//                    }) {
//                        Text("무비차트")
//                            .foregroundColor(.white)                   // 글자색 흰색
//                            .font(.system(size: 20, weight: .bold))    // 폰트 크기 & 두께
//                            .padding(.vertical, 10)
//                            .padding(.horizontal, 15)
//                            .buttonStyle(.glass)
//                            .background(                                // 글자 아래 배경
//                                RoundedRectangle(cornerRadius: 25)
//                                    .fill(Color(white: 0.7))           // 어두운 회색 배경
//                            )
//                    }
//                }
//                ScrollView(.horizontal, showsIndicators: false) { // 가로 스크롤
//                    HStack(spacing: 5) { // 카드 간격
//                        ForEach(viewModel.movieModel.indices, id: \.self) { index in
//                            MovieCard(movieInfo: viewModel.movieModel[index])
//                        }
//                    }
//                }
//                .frame(height: 250) // 카드 높이 맞춤
//            }
//        }
//        .frame(maxHeight: .infinity, alignment: .top)
//        .padding(.horizontal, 20)
//    }
//}
//
//#Preview {
//    MovieMainView()
//}
