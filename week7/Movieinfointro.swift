//
//  Movieinfointro.swift
//  3weeklean
//
//  Created by 육도연 on 11/17/25.
//
import SwiftUI
import Kingfisher

/// 영화 상세 뷰 (파일 이름: Movieinfointro.swift, struct 이름: movieinfointro)
struct movieinfointro: View { // (원본 파일 이름 준수)
    let movieInfo: MovieinfoModel //소문자 i로 통일
    
    // 현재 선택된 탭을 저장하는 상태 변수
    @State private var selectedTab: Tab = .details

    // 탭의 종류
    enum Tab {
        case details
        case reviews
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                //상단 대형 포스터 (backdrop_path 사용)
                KFImage(movieInfo.backdropURL)
                    .resizable()
                    .placeholder {
                        ZStack {
                            Color(.systemGray5)
                            ProgressView()
                        }
                    }
                    .scaledToFill() // 화면에 꽉 차도록
                    .frame(height: 250) // 높이 지정
                    .clipped() // 프레임 밖으로 나간 이미지 자르기
             
                // 영화 제목 (홈 화면에서 전달받음)
                Text(movieInfo.movieName)
                    .font(.title)
                    .bold()
                
                //원제목 (original_title)
                Text(movieInfo.originalTitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.bottom)
                
                //영화 개요 (overview)
                Text(movieInfo.overview)
                    .font(.body)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                
                
                VStack(spacing: 0) {
                    // --- 탭 버튼 (상세 정보 / 실관람평) ---
                    HStack {
                        // (원본 파일 이름 준수)
                        sevenTabButton(title: "상세 정보", isSelected: selectedTab == .details) {
                            selectedTab = .details
                        }
                        sevenTabButton(title: "실관람평", isSelected: selectedTab == .reviews) {
                            selectedTab = .reviews
                        }
                    }
                    .padding(.top, 20)

                    // --- 탭 버튼 아래의 회색 구분선 ---
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(.systemGray5))

                    // --- 선택된 탭에 따라 다른 내용을 보여주는 부분 ---
                    if selectedTab == .details {
                        // (원본 파일 이름 준수)
                        sevenDetailsView(movieInfo: movieInfo) // movieInfo 전달
                            .padding(.top, 20)
                    } else {
                        // (원본 파일 이름 준수)
                        sevenReviewsView()
                            .padding(.top, 20)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 10)
        }
        .padding(.horizontal, 10)
        .navigationTitle(movieInfo.movieName) // 네비게이션바 제목
        .navigationBarTitleDisplayMode(.inline)
    }
}

// --- 탭 뷰를 위한 Helper View들 (원본 파일 이름 준수) ---
struct sevenTabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        ScrollView{
            Button(action: action) {
                VStack(spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(isSelected ? .bold : .medium)
                        .foregroundColor(isSelected ? .black : .gray)
                        .padding(.horizontal)
                    
                    if isSelected {
                        Rectangle().frame(height: 2).foregroundColor(.black)
                    } else {
                        Rectangle().frame(height: 2).foregroundColor(.clear)
                    }
                }
            }
        }
    }
}

// --- 상세 정보 뷰 (API 데이터 사용) ---
struct sevenDetailsView: View {
    let movieInfo: MovieinfoModel // [수정] 소문자 i로 통일
    
    var body: some View {
        HStack(spacing: 15) {
            
            // [요청사항] 영화 포스터 (홈 화면에서 전달받은 posterURL 사용)
            KFImage(movieInfo.posterURL)
                .resizable()
                .placeholder {
                    ZStack {
                        Color(.systemGray6)
                        ProgressView()
                    }
                }
                .scaledToFill()
                .frame(width: 100, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 8) {
                // [요청사항] 관람 등급 (하드코딩된 값)
                Text(movieInfo.ageRating)
                // [요청사항] 개봉일 (release_date)
                Text("개봉: \(movieInfo.releaseDate)")
            }
            .font(.subheadline)
            .padding(.horizontal, 10)
            Spacer()
        }
    }
}

// --- 실관람평 뷰 ---
struct sevenReviewsView: View {
    var body: some View {
        VStack {
            Text("등록된 관람평이 없어요 😥")
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


#Preview("Movieinfointro Preview") {
    NavigationStack {
        movieinfointro(movieInfo: MovieinfoModel(
            id: 1,
            movieName: "F1 더 무비",
            originalTitle: "F1: The Movie",
            overview: "이것은 영화의 개요입니다. 레이싱에 대한 이야기이며, 아주 긴 텍스트가 될 수 있습니다. 이 공간을 채우기 위해 더 많은 글을 씁니다.",
            posterPath: "/qKN5G6dD9nL9S6LgJmKGYNSRKtk.jpg", // 예시 포스터
            backdropPath: "/3PjKBaLgS3nmdSj9sRXTZlD4U8j.jpg", // 예시 백드롭
            releaseDate: "2025-06-25"
        ))
    }
}
