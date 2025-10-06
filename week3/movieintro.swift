//
//  movieintro.swift
//  3weeklean
//
//  Created by 육도연 on 10/5/25.

//movieintro.swift
//--------------------------다시 코드 분석하기---------------------

import SwiftUI

struct movieintro: View {
    let movieInfo: MovieModel
    // 현재 선택된 탭을 저장하는 상태 변수 추가
    @State private var selectedTab: Tab = .details

    // 탭의 종류를 정의
    enum Tab {
        case details
        case reviews
    }

    var body: some View {
        ScrollView {
            VStack {
                // --- 기존 디자인 (그대로 유지) ---
                Image("F1intro")
                    .resizable()
                    .scaledToFit()
                    .padding()
             
                Text(movieInfo.movieName)
                    .font(.title)
                    .bold()
                
                Text("F1: The movie")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.bottom)
                
                Image("explain")
                    .resizable()
                    .scaledToFit()
                
                VStack(spacing: 0) {
                    // --- 탭 버튼 (상세 정보 / 실관람평) ---
                    HStack {
                        TabButton(title: "상세 정보", isSelected: selectedTab == .details) {
                            selectedTab = .details
                        }
                        TabButton(title: "실관람평", isSelected: selectedTab == .reviews) {
                            selectedTab = .reviews
                        }
                    }
                    .padding(.top, 20) // 상단 이미지와의 간격

                    // --- 탭 버튼 아래의 회색 구분선 ---
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(.systemGray5))

                    // --- 선택된 탭에 따라 다른 내용을 보여주는 부분 ---
                    if selectedTab == .details {
                        DetailsView()
                            .padding(.top, 20)
                    } else {
                        ReviewsView()
                            .padding(.top, 20)
                    }
                }
                
                Spacer() // 전체 콘텐츠를 위쪽으로 밀어 올리는 역할
            }
            .padding(.horizontal, 10)
        }
        .navigationTitle(movieInfo.movieName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// --- 탭 뷰를 위한 Helper View들 ---

// 탭 버튼을 위한 별도 뷰
struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.headline)
                    .fontWeight(isSelected ? .bold : .medium)
                    .foregroundColor(isSelected ? .black : .gray)
                    .padding(.horizontal)
                
                if isSelected {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.black)
                } else {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.clear)
                }
            }
        }
    }
}

// 상세 정보 뷰
struct DetailsView: View {
    var body: some View {
        HStack(spacing: 15) {
            Image("mvpo3")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 8) {
                Text("12세 이상 관람가")
                Text("2025.06.25 개봉")
            }
            .font(.subheadline)
            
            Spacer()
        }
    }
}

// 실관람평 뷰
struct ReviewsView: View {
    var body: some View {
        VStack {
            Text("등록된 관람평이 없어요 😥")
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


#Preview("movieintro Preview") {
    NavigationStack {
        movieintro(movieInfo: MovieModel(movieImage: Image("mvpo3"), movieName: "F1 더 무비", spectator: "누적관람수 20만"))
    }
}



#Preview("TabButton Preview") {
    HStack {
        TabButton(title: "선택됨", isSelected: true) { }
        TabButton(title: "선택 안됨", isSelected: false) { }
    }
    .padding()
}

#Preview("DetailsView Preview") {
    DetailsView()
        .padding()
}

#Preview("ReviewsView Preview") {
    ReviewsView()
        .padding()
}
/*
#preview{
 movieintro()
 }
 로 하면 리턴값이 없어서 문제가 된
 */
