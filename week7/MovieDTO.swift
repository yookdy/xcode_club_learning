//
//  MovieDTO.swift
//  3weeklean
//
//  Created by 육도연 on 11/17/25.
//
import Foundation

/// TMDB "Now Playing" API의 최상위 응답 구조 (파일 이름: MovieDTO.swift)
struct MovieResponse: Codable {
    let results: [MovieResult]
    let page: Int
    let totalPages: Int
    let dates: MovieDates?
    
    enum CodingKeys: String, CodingKey {
        case results, page, dates
        case totalPages = "total_pages"
    }
}

/// 날짜 범위
struct MovieDates: Codable {
    let maximum: String
    let minimum: String
}

/// 개별 영화 정보 DTO (API 응답)
struct MovieResult: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?       // "poster_path"
    let backdropPath: String?     // "backdrop_path"
    let releaseDate: String     // "release_date"
    let originalTitle: String   // "original_title"
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
    }
}
