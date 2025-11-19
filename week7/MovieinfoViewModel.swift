//
//  MovieinfoViewModel.swift
//  3weeklean
//
//  Created by 육도연 on 11/17/25.
//

import Foundation
import SwiftUI
import Moya

/// ViewModel (파일 이름: MovieinfoViewModel.swift)
/// class 이름: MovieinfoViewModel
@Observable
class MovieinfoViewModel {
    
    /// View에 바인딩될 영화 목록 (MovieinfoModel 사용)
    var movieModels: [MovieinfoModel] = [] // [수정] 소문자 i로 통일
    
    /// 에러 메시지
    var errorMessage: String?
    
    /// [개선] 로딩 상태
    var isLoading: Bool = false
    
    /// MoyaProvider
    private let provider = movieProvider
    
    //
    // "구버전" Moya(completion 사용)를 "신버전" async/await처럼 보이게 만드는 "다리" 함수
    // 이 함수가 'completion' 오류를 근본적으로 해결합니다.
    private func requestAsync(_ target: MovieService) async throws -> Response {
        //MovieService로 이동을 함
        return try await withCheckedThrowingContinuation { continuation in
            // "구버전" 방식으로 실제로 요청을 보냄
            provider.request(target) { result in //MovieService 부분에서 targetType 프로토콜을 가지고 값을 가져와서 respone으로 데이터를 변환을 함
                // "신버전"의 'continuation'을 통해 결과를 반환하거나 에러를 던짐
                switch result {
                case .success(let response):
                    continuation.resume(returning: response) // 성공 결과를 'await' 쪽으로 반환
                case .failure(let error):
                    continuation.resume(throwing: error) // 실패 에러를 'try' 쪽으로 던짐
                }
            }
        }
    }

    /// [요구사항] async/await를 사용한 API 호출 함수 (Now Playing 호출)
    @MainActor // UI 업데이트를 위해 메인 스레드에서 실행
    //영화 정보를 끌고 오게 만드는 함수----------------------------
    func fetchNowPlayingMovies() async {
        
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {//do-try-catch문으로
            //provider.request 대신, 우리가 만든 "다리" 함수(requestAsync)를 호출
            let response = try await requestAsync(.nowPlaying(language: "ko-KR", page: 1, region: "KR"))
            //requestAsync함수를 실행을 함
            
            //응답 DTO로 디코딩
            let movieResponse = try response.map(MovieResponse.self)
            //받은 데이터를 DTO로 객체로 변환을 함-->map을 이용을 해서 여러개를 받아준다고 생각 가능
            
            // [요구사항] DTO (MovieResult) -> Model (MovieinfoModel)로 매핑
            // (이 부분은 'completion' 오류가 해결되면 정상적으로 작동합니다)
            self.movieModels = movieResponse.results.map { result in
                MovieinfoModel( // [수정] 소문자 i로 통일
                    id: result.id,
                    movieName: result.title,
                    originalTitle: result.originalTitle,
                    overview: result.overview,
                    posterPath: result.posterPath,
                    backdropPath: result.backdropPath,
                    releaseDate: result.releaseDate
                )
            }
            
        } catch {
            // [요구사항] do-try-catch로 에러 핸들링
            self.errorMessage = "영화를 불러오는데 실패했습니다: \(error.localizedDescription)"
            print("API Error: \(error)")
        }
        
        isLoading = false
    }
}
