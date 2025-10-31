//
//  fiveMovieModel.swift
//  Megabox_project
//
//  Created by 육도연 on 11/1/25.
//
//fiveMovieModel.swift
import Foundation
import Combine

//1. Identifiable, Equatable 프로토콜 채택
//각각 id를 설정해줘서 구별할 수 있는 신분증 역활을 하고 Equatable이 값을 비교하는 로직을 만들어내는 역활을 만들어냄
//Eqatable은 값의 변경을 감지하는 역활을 함
struct FiveMovieModel: Identifiable, Equatable {
    // [!] 2. id를 UUID가 아닌 String으로 변경 (JSON과 맞추기 위함)
    let id: String
    let title: String
    let movieImage: String
    let age: Int
}


