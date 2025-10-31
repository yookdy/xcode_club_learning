//
//  fiveMovieViewModel.swift
//  Megabox_project
//
//  Created by 육도연 on 11/1/25.
//
//fiveMovieVewModel.swift 파일 이름
import Foundation
import Combine

// ObservableObject 프로토콜 채택, 사실상 이미지하고 연령, 제목, 리로딩 기능만 하고 있음
final class FiveMovieViewModel: ObservableObject {
    
    //@Published 속성으로 데이터 변경을 외부에 알림
    @Published var movies: [FiveMovieModel] = [
        // [!] id: "m-00X" 형식으로 JSON과 동일한 ID를 직접 지정합니다.
        .init(id: "m-002", title: "F1 더 무비", movieImage: "F1", age: 12),
        .init(id: "m-003", title: "귀멸의 칼날", movieImage: "demonslayer", age: 15),
        .init(id: "m-001", title: "어쩔수가없다", movieImage: "nochoice", age: 15),
        .init(id: "m-004", title: "원령 공주", movieImage: "monono", age: 15),
        .init(id: "m-005", title: "얼굴", movieImage: "Face", age: 15),
        .init(id: "m-006", title: "보스", movieImage: "boss", age: 12),
        .init(id: "m-007", title: "야당", movieImage: "theoppo", age: 12),
        .init(id: "m-008", title: "더 로즈", movieImage: "theRose", age: 12),
    ]
    @Published var query: String = ""//검색
    @Published var results: [FiveMovieModel] = []//결과
    @Published var isLoading = false//로딩처리
    @Published var errorMessage: String?//에러메세지
    @Published var selectedMovie: FiveMovieModel?
    
    
    

    private var bag = Set<AnyCancellable>()
    
    
    
    // 검색하는 기능을 하고 있음 시트에서만 적용이되게 만듦
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
    private func search(query: String) -> AnyPublisher<[FiveMovieModel], Error> {   //query에서 변화를 감지하는 상황에서 위가 실현됨
        return Future<[FiveMovieModel], Error> { [weak self] promise in
            let delay = Double(Int.random(in: 300...700)) / 1000.0
            guard let self else { return }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                // [!] 검색 로직도 title로만 비교
                let filtered = self.movies.filter { $0.title.lowercased().contains(query.lowercased()) }
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

