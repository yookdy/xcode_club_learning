//
//  moviecard.swift
//  3weeklean
//
//  Created by 육도연 on 10/4/25.
//

//MovieCard.swift
import SwiftUI

struct MovieCard: View {
    let movieInfo: MovieModel
    var body: some View {
        VStack(spacing: 3) {
            // 영화 이미지
            NavigationLink(destination: movieintro(movieInfo: movieInfo)) {
                movieInfo.movieImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140)
            }
            
            Button(action: {
                print("바로 예매 버튼 클릭")
            }) {
                Text("바로 예매")
                    .font(.headline)
                    .foregroundStyle(Color.purple)      // 글씨색
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .overlay(                       // 테두리 적용
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.purple, lineWidth: 2)
                    )
            }
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    Spacer(minLength: 0)
                    Text(movieInfo.movieName)
                        .font(.headline)
                        .lineLimit(1)                        // 세로 한 줄
                        .fixedSize(horizontal: true, vertical: false) // 가로는 내용 길이대로
                    Spacer(minLength: 0)
                }
                .frame(minWidth: 120)
            }
            .frame(width: 120)                             // 스크롤 영역 프레임
            Text(movieInfo.spectator)// 카드 프레임과 최소 가로 맞춤
            // 바로 예매 버튼
        }
        .frame(width: 140, height: 230)
        .background(Color.clear)

    }
}

#Preview {
    MovieCard(movieInfo: MovieModel(movieImage: Image("mvpo2"), movieName: "극장판 귀멸의 칼날 무한성편",spectator: "누적관람수 20만"))
}

