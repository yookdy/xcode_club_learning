//
//  fivedayinfo.swift
//  Megabox_project
//
//  Created by 육도연 on 11/1/25.

//fivedayinfo.swift
import SwiftUI
import Combine

// [!] 1. Equatable 프로토콜 추가
struct FiveDayInfo: Identifiable, Equatable {
    let id = UUID()
    let dayOfMonth: String
    let dayOfWeek: String
    let monthAndDay: String
    // [!] 2. JSON과 비교할 "2025-09-22" 형식의 dateString 추가
    let dateString: String
}

class FiveDateSelectionViewModel: ObservableObject {
    
    // 이 데이터는 변경되지 않으므로 @Published가 필요 없습니다.
    let days: [FiveDayInfo] = [
        // [!] 3. dateString 값을 각 날짜에 맞게 초기화
        .init(dayOfMonth: "22", dayOfWeek: "오늘", monthAndDay: "9.22", dateString: "2025-09-22"),
        .init(dayOfMonth: "23", dayOfWeek: "내일", monthAndDay: "9.23", dateString: "2025-09-23"),
        .init(dayOfMonth: "24", dayOfWeek: "수", monthAndDay: "9.24", dateString: "2025-09-24"),
        .init(dayOfMonth: "25", dayOfWeek: "목", monthAndDay: "9.25", dateString: "2025-09-25"),
        .init(dayOfMonth: "26", dayOfWeek: "금", monthAndDay: "9.26", dateString: "2025-09-26"),
        .init(dayOfMonth: "27", dayOfWeek: "토", monthAndDay: "9.27", dateString: "2025-09-27"),
        .init(dayOfMonth: "28", dayOfWeek: "일", monthAndDay: "9.28", dateString: "2025-09-28")
    ]
    
    // [!] 4. UUID를 받아서 "2025-09-22" 형식의 문자열을 반환하는 함수 추가
    func getDateString(from id: UUID?) -> String? {
        guard let id = id else { return nil }
        // days 배열에서 id가 일치하는 첫 번째 항목을 찾아 dateString을 반환
        return days.first(where: { $0.id == id })?.dateString
    }
}



struct FiveDateSelectionView: View {
    @ObservedObject var viewModel: FiveDateSelectionViewModel
    
    // FiveMovieView로부터 현재 선택된 ID를 @Binding으로 받습니다.
    @Binding var selectedDateUUID: UUID?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.days) { day in
                    Button(action: {
                        // @Binding으로 연결된 selectedDateUUID를 직접 변경합니다.
                        if selectedDateUUID == day.id {
                            selectedDateUUID = nil
                        } else {
                            selectedDateUUID = day.id
                        }
                    }) {
                        VStack {
                            // selectedDateUUID를 기준으로 UI를 그립니다.
                            Text(selectedDateUUID == day.id ? day.monthAndDay : day.dayOfMonth)
                                .font(.custom("Pretendard-Bold", size: 20))

                            Text(day.dayOfWeek)
                                .font(.custom("Pretendard-Regular", size: 12))
                                .padding(.top, 1)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 8)
                        .background(selectedDateUUID == day.id ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color.clear)
                        .cornerRadius(10)
                        // [!] Color 타입을 명시하여 컴파일러 혼란 방지
                        .foregroundStyle(selectedDateUUID == day.id ? Color.white : (day.dayOfWeek == "토" ? Color.blue : (day.dayOfWeek == "일" ? Color.red : Color.black)))
                        .animation(.easeOut(duration: 0.2), value: selectedDateUUID)
                    }
                }
            }
        }
    }
}

