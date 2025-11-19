//
//  MovieService.swift
//  3weeklean
//
//  Created by 육도연 on 11/17/25.
//
import Foundation
import Moya
import Alamofire

/// Moya Provider (파일 이름: MovieService.swift)
let movieProvider = MoyaProvider<MovieService>()

/// TMDB API 서비스 정의 (Now Playing 포함)
enum MovieService {
    case nowPlaying(language: String, page: Int, region: String)
}

extension MovieService: TargetType {
    
    //프로토콜을 실행을 하게 만드는 부분
    /// Base URL
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    /// 엔드포인트 경로
    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing" // [요청사항] Now Playing API 경로
        }
    }
    
    /// HTTP Method
    var method: Moya.Method {
        switch self {
        case .nowPlaying:
            return .get
        }
    }
    
    
    /// API 요청 파라미터 (Query)
    var task: Moya.Task {
        switch self {
        case .nowPlaying(let language, let page, let region):   //nowPlaying로 get메서드를 실행을 하게함
            let parameters: [String: Any] = [
                "api_key": Config.tmdbApiKey, // Config에서 API 키 사용
                "language": language,
                "page": page,
                "region": region
            ]
            // Query Parameters로 전송
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    /// HTTP 헤더
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
