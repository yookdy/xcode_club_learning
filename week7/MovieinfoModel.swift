//
//  MovieinfoModel.swift
//  3weeklean
//
//  Created by 육도연 on 11/17/25.
//
import Foundation
import SwiftUI

/// View에서 사용할 영화 모델 (파일 이름: MovieinfoModel.swift)
/// struct 이름: MovieinfoModel (소문자 i로 통일)
struct MovieinfoModel: Identifiable {
    let id: Int // TMDB ID
    let movieName: String // title
    let originalTitle: String // original_title
    let overview: String // overview
    let posterPath: String? // poster_path
    let backdropPath: String? // backdrop_path
    let releaseDate: String // release_date
    
    // [요구사항] 누적 관객수는 하드코딩
    let spectator: String = "누적관람수 100만"
    
    // [요구사항] 영화 관람 등급은 하드코딩
    let ageRating: String = "12세 이상 관람가"
    
    /// Kingfisher에서 사용할 포스터 URL
    var posterURL: URL? {
        if let path = posterPath {
            return URL(string: Config.imageBaseUrl + path)//api주소에서 이미지를 가져오는 거임
        }
        return nil // 포스터 경로가 없을 경우 nil
    }
    
    /// Kingfisher에서 사용할 백드롭 URL
    var backdropURL: URL? {
        if let path = backdropPath {
            return URL(string: Config.backdropBaseUrl + path)
        }
        return nil // 백드롭 경로가 없을 경우 nil
    }
}
