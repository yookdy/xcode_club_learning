//
//  fiveMovieScheduleModels.swift
//  Megabox_project
//
//  Created by 육도연 on 11/2/25.
//
//  UserModel.swift의 DTO/Domain 패턴을 적용한 파일입니다.
//

import Foundation

// MARK: - 1. Domain Models (View가 실제 사용하는 데이터)

struct Theater: Identifiable {
    let id = UUID()
    let title: String
    let format: String
    let timeSlots: [ShowtimeSlot]
}

struct ShowtimeSlot: Identifiable, Equatable {
    let id = UUID()
    let startTime: String
    let endTime: String
    let available: Int
    let total: Int
    var audienceInfo: String { "\(available) / \(total)" }
}


// MARK: - 2. DTOs (JSON의 모양과 1:1로 일치하는 모델)

// JSON 최상위 구조
struct MovieScheduleResponse: Codable {
    let status: String
    let message: String
    let data: MovieData
}

// JSON "data" 객체
struct MovieData: Codable {
    let movies: [MovieScheduleDTO]
}

// JSON "movies" 배열의 요소
struct MovieScheduleDTO: Codable {
    let id: String
    let title: String
    let ageRating: String
    let schedules: [DateScheduleDTO]
    
    // JSON의 snake_case (age_rating)를 camelCase (ageRating)로 매핑
    enum CodingKeys: String, CodingKey {
        case id, title, schedules
        case ageRating = "age_rating"
    }
}

// JSON "schedules" 배열의 요소
struct DateScheduleDTO: Codable {
    let date: String
    let areas: [AreaItemDTO]
}

// JSON "areas" 배열의 요소
struct AreaItemDTO: Codable {
    let area: String
    let items: [ScheduleItemDTO]
}

// JSON "items" 배열의 요소
struct ScheduleItemDTO: Codable {
    let auditorium: String
    let format: String
    let showtimes: [ShowtimeDTO]
}

// JSON "showtimes" 배열의 요소
struct ShowtimeDTO: Codable {
    let start: String
    let end: String
    let available: Int
    let total: Int
}


// MARK: - 3. Mappers (DTO를 Domain Model로 변환)

// DTO에 'toDomain' 함수를 추가하여 변환 로직을 캡슐화합니다.
extension ScheduleItemDTO {
    // ScheduleItemDTO(JSON틀)를 Theater(View용 모델)로 변환
    func toDomain() -> Theater {
        // 하위 DTO(ShowtimeDTO)들도 .toDomain()을 호출해 변환
        let domainTimeSlots = self.showtimes.map { $0.toDomain() }
        
        return Theater(
            title: self.auditorium,
            format: self.format,
            timeSlots: domainTimeSlots
        )
    }
}

extension ShowtimeDTO {
    // ShowtimeDTO(JSON틀)를 ShowtimeSlot(View용 모델)로 변환
    func toDomain() -> ShowtimeSlot {
        return ShowtimeSlot(
            startTime: self.start,
            endTime: self.end,
            available: self.available,
            total: self.total
        )
    }
}

