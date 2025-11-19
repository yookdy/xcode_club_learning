//
//  config.swift
//  3weeklean
//
//  Created by 육도연 on 11/17/25.
//
import Foundation


//api 키 정보
struct Config {
    /// TMDB API 키 (infomemo.md에서 가져옴)
    static let tmdbApiKey = "3a2a59195e471d4cc9322e94ca8ffe60"
    
    /// 영화 포스터 이미지 URL (w500)
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    /// 영화 백드롭 이미지 URL (original)
    static let backdropBaseUrl = "https://image.tmdb.org/t/p/original"
    
}
