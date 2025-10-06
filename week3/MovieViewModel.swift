//
//  MovieViewModel.swift
//  3weeklean
//
//  Created by 육도연 on 10/4/25.

//MovieViewModel.swift
import Foundation
import SwiftUI

@Observable
class MovieViewModel {
    let movieModel: [MovieModel] = [
        .init(movieImage: .init(.mvpo1), movieName: "어쩔 수 없다", spectator: "누적관람수 20만"),
        .init(movieImage: .init(.mvpo2), movieName: "극장판 귀멸의 칼날 무한성", spectator: "누적관람수 20만"),
        .init(movieImage: .init(.mvpo3), movieName: "F1 더 무비",spectator: "누적관람수 20만"),
        .init(movieImage: .init(.mvpo4), movieName: "얼굴",spectator: "누적관람수 20만"),
        .init(movieImage: .init(.mvpo5), movieName: "모노노케 히메",spectator: "누적관람수 20만")
        
    ]//영화 정보
    
//    /// 이전 영화로 돌아가기, 단, 첫 번째 영화일 경우 마지막 영화로 전환
//        public func previousMovie() {
//            currentIndex = (currentIndex - 1 + movieModel.count) % movieModel.count
//        }
//    /// 오른쪽 버튼을 눌렀을 때 다음 영화로 이동하는 함수
//    public func nextMovie() {
//        currentIndex = (currentIndex + 1) % movieModel.count
//    }
}
