//
//  movieinfocard.swift
//  3weeklean
//
//  Created by 육도연 on 11/17/25.
//
import SwiftUI
import Kingfisher

/// 영화 카드 뷰 (파일 이름: movieinfocard.swift)
/// struct 이름: MovieinfoCard (원본 파일 이름 준수)
struct MovieinfoCard: View {
    let movieInfo: MovieinfoModel

    var body: some View {
        VStack(spacing: 3) {
            
            NavigationLink(destination: movieinfointro(movieInfo: movieInfo)) { // [수정] movieinfointro (원본 파일 이름)
                
                // [요청사항] Kingfisher를 사용하여 URL 이미지 로드
                KFImage(movieInfo.posterURL)
                    .resizable()
                    .placeholder { // [요청사항] 로딩 시 ProgressView
                        ZStack {
                            Color(.systemGray6) // 플레이스홀더 배경색
                            ProgressView()
                        }
                    }
                    .scaledToFit()
                    .frame(width: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 8)) // 디자인 통일
            }
            .frame(height: 210) // 이미지 높이 고정 (레이아웃 안정화)
            
            // --- (기존 '바로 예매' 버튼 UI) ---
            Button(action: { print("바로 예매 버튼 클릭") }) {
                Text("바로 예매")
                    .font(.headline)
                    .foregroundStyle(Color(red: 0.4, green: 0.05, blue: 0.85))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .overlay( RoundedRectangle(cornerRadius: 16).stroke(Color(red: 0.4, green: 0.05, blue: 0.85), lineWidth: 2) )
            }
            
            //ScrollView를 Text.lineLimit(1)로 변경하여 더 깔끔하게 처리
            Text(movieInfo.movieName) // API 데이터
                .font(.headline)
                .lineLimit(1) // 한 줄로 제한
                .truncationMode(.tail) // ...으로 생략
                .frame(width: 120)
            
            // API (하드코딩) 데이터 사용
            Text(movieInfo.spectator) // 하드코딩된 값
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 140, height: 260) // 전체 카드 높이 조절
        .background(Color.clear)
    }
}

#Preview {
    MovieinfoCard(movieInfo: MovieinfoModel( // [수정] 소문자 i로 통일
        id: 1,
        movieName: "극장판 귀멸의 칼날 무한성편",
        originalTitle: "Kimetsu no Yaiba",
        overview: "...",
        posterPath: "/example.jpg", // 프리뷰용
        backdropPath: "/example.jpg",
        releaseDate: "2025.01.01"
    ))
}
