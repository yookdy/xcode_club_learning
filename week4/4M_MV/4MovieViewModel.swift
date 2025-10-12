//
//  4MovieViewModel.swift
//  Megabox_project
//
//  Created by 육도연 on 10/11/25.

//4MovieVewModel.swift 파일 이름
/**\
 import Foundation
 import Combine

 // ObservableObject 프로토콜 채택
 final class FourMovieViewModel: ObservableObject {
     
     //@Published 속성으로 데이터 변경을 외부에 알림
     @Published var movies: [FourMovieModel] = [
         .init(title: "F1 더 무비", movieImage: "F1"),
         .init(title: "귀멸의 칼날", movieImage: "demonslayer"),
         .init(title: "어쩔수가없다", movieImage: "nochoice"),
         .init(title: "원령 공주", movieImage: "monono"),
         .init(title: "얼굴", movieImage: "Face"),
         .init(title: "보스", movieImage: "boss"),
         .init(title: "야당", movieImage: "theoppo"),
         .init(title: "더 로즈", movieImage: "theRose"),
     ]
     @Published var query: String = ""//검색
     @Published var results: [FourMovieModel] = []//결과
     @Published var isLoading = false//로딩처리
     @Published var errorMessage: String?//에러메세지
     @Published var selectedMovie: FourMovieModel?
     
     

     private var bag = Set<AnyCancellable>()
     
     init() {
         $query//검색 변화
             .debounce(for: .milliseconds(1000), scheduler: DispatchQueue.main)
             .removeDuplicates()
             .handleEvents(receiveOutput: { [weak self] _ in
                 self?.errorMessage = nil
             })
             .flatMap { query in
                 self.search(query: query)
             }
             .receive(on: DispatchQueue.main)
             .sink { [weak self] completion in
                 if case .failure(let err) = completion {
                     self?.errorMessage = "검색 실패: \(err.localizedDescription)"
                     self?.results = []
                 }
             }
             receiveValue: { [weak self] items in
                 self?.results = items//4주차에서 배운 내용을 이용함
             }//찾은 내용이 있을 때 결과값을 담는 형태
             .store(in: &bag)
     }
     private func search(query: String) -> AnyPublisher<[FourMovieModel], Error> {   //query에서 변화를 감지하는 상황에서 위가 실현됨
         return Future<[FourMovieModel], Error> { [weak self] promise in
             let delay = Double(Int.random(in: 300...700)) / 1000.0
             guard let self else { return }
             
             DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                 let filtered = self.movies.filter { $0.title.lowercased().contains(query) }
                 promise(.success(filtered))
             }
         }
         .handleEvents(
             receiveSubscription: { _ in
                 DispatchQueue.main.async {
                     self.isLoading = true
                 }
             },
             receiveCompletion: { _ in
                 DispatchQueue.main.async {
                     self.isLoading = false
                 }
             }
         )
         .eraseToAnyPublisher()
     }
 }
 **/
