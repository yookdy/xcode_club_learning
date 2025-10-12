////
////  dayinfo.swift
////  Megabox_project
////
////  Created by 육도연 on 10/13/25.
////
//import SwiftUI
//import Combine
//
//// 각 날짜 버튼에 필요한 데이터를 담는 구조체
//// Identifiable 프로토콜을 따라야 ForEach에서 고유하게 식별 가능
//struct DayInfo: Identifiable {
//    let id = UUID() // 각 항목을 구분하기 위한 고유 ID
//    let dayOfMonth: String // "22", "23" 등 날짜 숫자
//    let dayOfWeek: String  // "오늘", "내일", "수" 등 요일
//    let monthAndDay: String // 선택되었을 때 표시될 "9.22" 같은 텍스트
//}
//
//class DateSelectionViewModel: ObservableObject {
//    // UI가 관찰해야 할 데이터 앞에 @Published를 붙입니다.
//    @Published var selectedDateId: UUID? = nil
//    
//    // 이 데이터는 변경되지 않으므로 @Published가 필요 없습니다.
//    let days: [DayInfo] = [
//        .init(dayOfMonth: "22", dayOfWeek: "오늘", monthAndDay: "9.22"),
//        .init(dayOfMonth: "23", dayOfWeek: "내일", monthAndDay: "9.23"),
//        .init(dayOfMonth: "24", dayOfWeek: "수", monthAndDay: "9.24"),
//        .init(dayOfMonth: "25", dayOfWeek: "목", monthAndDay: "9.25"),
//        .init(dayOfMonth: "26", dayOfWeek: "금", monthAndDay: "9.26"),
//        .init(dayOfMonth: "27", dayOfWeek: "토", monthAndDay: "9.27"),
//        .init(dayOfMonth: "28", dayOfWeek: "일", monthAndDay: "9.28")
//    ]
//}
//
//
//
//struct DateSelectionView: View {
//    //ViewModel을 외부에서 받아 사용합니다.
//    // @ObservedObject는 부모 뷰가 제공하는 ViewModel을 구독합니다.
//    @ObservedObject var viewModel: DateSelectionViewModel
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 10) {
//                // ViewModel에 있는 days 데이터를 사용합니다.
//                ForEach(viewModel.days) { day in
//                    Button(action: {
//                        // ViewModel의 상태를 변경합니다.
//                        if viewModel.selectedDateId == day.id {
//                            viewModel.selectedDateId = nil
//                        } else {
//                            viewModel.selectedDateId = day.id
//                        }
//                    }) {
//                        VStack {
//                            // ViewModel의 selectedDateId를 기준으로 UI를 그립니다.
//                            Text(viewModel.selectedDateId == day.id ? day.monthAndDay : day.dayOfMonth)
//                                .font(.custom("Pretendard-Bold", size: 20))
//
//                            Text(day.dayOfWeek)
//                                .font(.custom("Pretendard-Regular", size: 12))
//                                .padding(.top, 1)
//                        }
//                        .padding(.vertical, 8)
//                        .padding(.horizontal, 8)
//                        .background(viewModel.selectedDateId == day.id ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color.clear)
//                        .cornerRadius(10)
//                        .foregroundStyle(viewModel.selectedDateId == day.id ? .white : (day.dayOfWeek == "토" ? .blue : (day.dayOfWeek == "일" ? .red : .black)))
//                        .animation(.easeOut(duration: 0.2), value: viewModel.selectedDateId)
//                    }
//                }
//            }
//        }
//    }
//}
