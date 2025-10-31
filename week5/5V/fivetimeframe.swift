//
//  fivetimeframe.swift
//  Megabox_project
//
//  Created by 육도연 on 11/1/25.
//
//  UserViewModel.swift의 async/await 패턴을 적용한 파일입니다.
//

import SwiftUI
import Combine

// MARK: - Location Enum
enum Location: String, CaseIterable {
    case gangnam = "강남"
    case hongdae = "홍대"
    case sinchon = "신촌"
}

// MARK: - ViewModel
@MainActor // @Published 프로퍼티를 메인 스레드에서 안전하게 업데이트
final class FiveTimeframeViewModel: ObservableObject {
    
    // 1. 원본 DTO 데이터 (JSON 파싱 결과)
    private var allMovieSchedules: MovieData?

    // 2. View로 전달할 최종 Domain Model
    @Published var displayableTheaters: [Theater] = []
    
    // 3. 로딩 및 에러 상태 (UserViewModel과 동일)
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // 4. View로부터 받을 3가지 조건 선택이 되야지만 작동을 해서 메인 코드
    @Published var selectedMovieID: String? {
        didSet { updateDisplayableTheaters() }
    }
    @Published var selectedDateString: String? {
        didSet { updateDisplayableTheaters() }
    }
    @Published var selectedLocations: Set<Location> = [] {
        didSet { updateDisplayableTheaters() }
    }
    
    // 5. 시간표 선택 상태
    @Published var selectedTimeSlotID: UUID? = nil

    // init()은 비워두고, View의 .task에서 loadScheduleData()를 호출
    init() { }
    
    // MARK: - 1. JSON 데이터 로드 (Async/Await)
    
    // 두 경로(root, "5V")를 모두 탐색하는 헬퍼 함수
    private func findJsonUrl() -> URL? {
        if let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json") {
            print("ℹ️ JSON Path: Found in Bundle root.")
            return url
        }
        if let url = Bundle.main.url(forResource: "MovieSchedule", withExtension: "json", subdirectory: "5V") {
            print("ℹ️ JSON Path: Found in '5V' subdirectory.")
            return url
        }
        return nil
    }
    
    // UserViewModel의 fetchUsers()와 동일한 async/await 패턴
    func loadScheduleData() async {
        // 이미 로딩했거나 로딩 중이면 중복 실행 방지
        guard allMovieSchedules == nil, !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        // 1. 파일 URL 찾기
        guard let url = findJsonUrl() else {
            errorMessage = "MovieSchedule.json 파일을 찾을 수 없습니다."
            isLoading = false
            return
        }

        // 2. 데이터 로드 (do-try-catch) 5주차에서 배운 문법 내용 직접 데이터를 끌고 오는 부분
        // 데이터를 끌고 오고 맞는디 확인을 하고 디코딩을 하는 파트임
        do {
            let data = try Data(contentsOf: url)
            
            // 3. 디코딩 (JSON -> DTO)
            // DTO(MovieScheduleResponse)가 CodingKeys를 사용하므로
            // keyDecodingStrategy는 더 이상 필요 없습니다.
            let response = try JSONDecoder().decode(MovieScheduleResponse.self, from: data)
            
            // 4. DTO를 원본 변수에 저장
            self.allMovieSchedules = response.data
            self.isLoading = false
            print(" JSON Succeeded: Successfully loaded \(self.allMovieSchedules?.movies.count ?? 0) movies.")
            
        } catch {
            // 디코딩 또는 데이터 로드 실패
            print("❌ JSON FAILED (Loading/Decoding Error): \(error)")
            errorMessage = "데이터 로드 중 오류 발생: \(error.localizedDescription)"
            self.isLoading = false
        }
    }

    // MARK: - 2. 데이터 필터링 (DTO -> Domain)
    // 디코딩하는 내용에서 이름같은거를 전환해주는 부분
    private func updateDisplayableTheaters() {
        
        // 원본 DTO 데이터가 없거나, 조건이 충족되지 않으면 필터링 중지
        guard let movieID = selectedMovieID,
              let date = selectedDateString,
              !selectedLocations.isEmpty,
              let allData = allMovieSchedules else {
            self.displayableTheaters = []
            return
        }

        // 1. 영화 ID로 DTO 찾기
        guard let movieDTO = allData.movies.first(where: { $0.id == movieID }) else {
            self.displayableTheaters = []
            return
        }
        
        // 2. 날짜로 DTO 찾기
        guard let scheduleDTO = movieDTO.schedules.first(where: { $0.date == date }) else {
            self.displayableTheaters = []
            return
        }

        var theatersToShow: [Theater] = []
        
        // 3. 선택된 지역(들)을 순회
        for location in selectedLocations {
            if let areaDTO = scheduleDTO.areas.first(where: { $0.area == location.rawValue }) {
                
                // [!]
                // [!] 여기가 핵심 수정 사항입니다!
                // [!] .map { $0.toDomain() }을 사용하여
                // [!] [ScheduleItemDTO]를 [Theater]로 자동 변환합니다.
                // [!] UserViewModel의 패턴과 동일합니다.
                // [!]
                let theaters = areaDTO.items.map { $0.toDomain() }
                
                theatersToShow.append(contentsOf: theaters)
            }
        }
        
        // 4. 최종 결과물(Domain Model)을 @Published 변수에 할당
        self.displayableTheaters = theatersToShow //담은 내용을 저장하는 역활을 함
    }
    
    // MARK: - 3. 유저 인터랙션
    func selectLocation(_ location: Location) {
        if selectedLocations.contains(location) {
            selectedLocations.remove(location)
        } else {
            selectedLocations.insert(location)
        }
    }
    
    func selectTimeSlot(timeSlot: ShowtimeSlot) {
        if selectedTimeSlotID == timeSlot.id {
            selectedTimeSlotID = nil
        } else {
            selectedTimeSlotID = timeSlot.id
        }
    }
}

