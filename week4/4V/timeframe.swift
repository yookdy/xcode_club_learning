////
////  dateframe.swift
////  Megabox_project
////
////  Created by 육도연 on 10/12/25.
//
////timeframe.swift
//import SwiftUI
//import Combine
//
//// MARK: - Model
//struct TimeframeModel: Identifiable {
//    let id = UUID()
//    let startTime: String
//    let endTime: String
//    let currentAudience: Int
//    let totalSeats: Int
//    var audienceInfo: String { "\(currentAudience) / \(totalSeats)" }
//}
//
//// MARK: - ViewModel
//final class TimeframeViewModel: ObservableObject {
//    @Published var gtimeSlots: [TimeframeModel] = []
//    @Published var htimeSlots: [TimeframeModel] = []
//    @Published var h2timeSlots: [TimeframeModel] = []
//    
//    //nil에서 위치를 저장하지 않고 불리안으로 저장을 해도 될 수도??
//    @Published var gselectedLocation: String? = nil
//    @Published var hselectedLocation: String? = nil
//    @Published var sselectedLocation: String? = nil
//    //현재 선택된 시간표의 ID를 저장할 변수 추가
//    @Published var selectedTimeSlotID: UUID? = nil
//    
//    //시간표를 선택/해제하는 함수 추가
//    func selectTimeSlot(timeSlot: TimeframeModel) {
//        // 이미 선택된 시간표를 다시 누르면 선택 해제 (nil)
//        if selectedTimeSlotID == timeSlot.id {
//            selectedTimeSlotID = nil
//        } else {
//            // 다른 시간표를 누르면 선택 변경
//            selectedTimeSlotID = timeSlot.id
//        }
//    }
//    
//    
//    func gtoggleGangnamSelection() {
//        // 버튼을 누르면 선택 상태를 토글(on/off)
//        if gselectedLocation == "강남" {
//            gselectedLocation = nil // 이미 선택된 상태면 취소
//        } else {
//            gselectedLocation = "강남" // 아니면 "강남"으로 선택
//        }
//        
//        // 여기에 "강남"이 선택되었을 때 필요한 데이터 로딩 로직 등을 추가할 수 있습니다.
//        // مثلاً fetchTimeSlots(for: "강남")
//    }
//    func htoggleGangnamSelection() {
//        // 버튼을 누르면 선택 상태를 토글(on/off)
//        if hselectedLocation == "홍대" {
//            hselectedLocation = nil // 이미 선택된 상태면 취소
//        } else {
//            hselectedLocation = "홍대" // 아니면 "강남"으로 선택
//        }
//        
//        // 여기에 "강남"이 선택되었을 때 필요한 데이터 로딩 로직 등을 추가할 수 있습니다.
//        // fetchTimeSlots(for: "강남")
//    }
//    func stoggleGangnamSelection() {
//        // 버튼을 누르면 선택 상태를 토글(on/off)
//        if sselectedLocation == "신촌" {
//            sselectedLocation = nil // 이미 선택된 상태면 취소
//        } else {
//            sselectedLocation = "신촌" // 아니면 "강남"으로 선택
//        }
//        
//        // 여기에 "강남"이 선택되었을 때 필요한 데이터 로딩 로직 등을 추가할 수 있습니다.
//        // fetchTimeSlots(for: "강남")
//    }
//
//    init() {
//        gfetchTimeSlots()
//        hfetchTimeSlots()
//        h2fetchTimeSlots()
//    }
//
//    func gfetchTimeSlots() {
//        self.gtimeSlots = [
//            TimeframeModel(startTime: "11:30", endTime: "~13:58", currentAudience: 109, totalSeats: 116),
//            TimeframeModel(startTime: "14:20", endTime: "~14:48", currentAudience: 19, totalSeats: 116),
//            TimeframeModel(startTime: "17:05", endTime: "~19:28", currentAudience: 01, totalSeats: 116),
//            TimeframeModel(startTime: "19:45", endTime: "~22:02", currentAudience: 100, totalSeats: 116),
//            TimeframeModel(startTime: "22:20", endTime: "~00:04", currentAudience: 116, totalSeats: 116)
//        ]
//    }
//    func hfetchTimeSlots(){
//        self.htimeSlots = [
//            TimeframeModel(startTime: "09:30", endTime: "~11:50", currentAudience: 75, totalSeats: 116),
//            TimeframeModel(startTime: "12:00", endTime: "~14:26", currentAudience: 102, totalSeats: 116),
//            TimeframeModel(startTime: "14:45", endTime: "~17:04", currentAudience: 88, totalSeats: 116),
//        ]
//    }
//    func h2fetchTimeSlots() {
//        self.h2timeSlots = [
//            TimeframeModel(startTime: "11:30", endTime: "~13:58", currentAudience: 34, totalSeats: 116),
//            TimeframeModel(startTime: "14:20", endTime: "~14:48", currentAudience: 100, totalSeats: 116),
//            TimeframeModel(startTime: "17:05", endTime: "~19:28", currentAudience: 13, totalSeats: 116),
//            TimeframeModel(startTime: "19:45", endTime: "~22:02", currentAudience: 95, totalSeats: 116)
//        ]
//    }
//}
//
//// MARK: - View
//struct TimeframeView: View {
//    @StateObject private var viewModel = TimeframeViewModel()
//    
//    // 그리드 레이아웃을 정의합니다. (최소 너비 80, 화면 크기에 따라 개수 유연하게 조절)
//    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 80))]
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                
//                // --- 지역 선택 버튼 ---
//                HStack {
//                    // "강남" 버튼
//                    Button("강남") {
//                        viewModel.gtoggleGangnamSelection()
//                    }
//                    .buttonStyle(LocationButtonStyle(isSelected: viewModel.gselectedLocation != nil))
//                    
//                    // "홍대" 버튼
//                    Button("홍대") {
//                        viewModel.htoggleGangnamSelection()
//                    }
//                    .buttonStyle(LocationButtonStyle(isSelected: viewModel.hselectedLocation != nil))
//                    
//                    // "신촌" 버튼
//                    Button("신촌") {
//                        viewModel.stoggleGangnamSelection()
//                    }
//                    .buttonStyle(LocationButtonStyle(isSelected: viewModel.sselectedLocation != nil))
//                }
//                
//                // --- 강남 시간표 (선택됐을 때만 보임) ---
//                if viewModel.gselectedLocation != nil {
//                    TheaterSectionView(
//                        title: "크리클라이너 1관",
//                        format: "2D",
//                        timeSlots: viewModel.gtimeSlots,
//                        columns: columns,
//                        viewModel: viewModel
//                    )
//                }
//                
//                // --- 홍대 시간표 (선택됐을 때만 보임) ---
//                if viewModel.hselectedLocation != nil {
//                    TheaterSectionView(
//                        title: "BTS관 (7층 1관 [Laser])",
//                        format: "2D",
//                        timeSlots: viewModel.htimeSlots,
//                        columns: columns,
//                        viewModel: viewModel
//                    )
//                    TheaterSectionView(
//                        title: "BTS관 (9층 2관 [Laser])",
//                        format: "2D",
//                        timeSlots: viewModel.h2timeSlots, // 새로 추가한 데이터 사용
//                        columns: columns,
//                        viewModel: viewModel
//                    )
//                }
//                
//                
//                // --- 신촌 시간표 (선택됐을 때만 보임) ---
//                if viewModel.sselectedLocation != nil {
//                    // 신촌 데이터는 없으므로, 비어있다는 텍스트를 표시
//                    Text("신촌점은 상영 정보가 없습니다.")
//                        .padding()
//                        .foregroundStyle(.secondary)
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("시간표") // 예시 타이틀
//    }
//}
//
//// MARK: - 재사용 가능한 뷰 컴포넌트
//
//// 영화관 섹션 전체를 그리는 뷰
//struct TheaterSectionView: View {
//    let title: String
//    let format: String
//    let timeSlots: [TimeframeModel]
//    let columns: [GridItem]
//    
//    //ViewModel을 받기 위해 @ObservedObject 추가
//        @ObservedObject var viewModel: TimeframeViewModel
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            HStack {
//                Text(title).font(.headline).fontWeight(.bold)
//                Spacer()
//                Text(format).font(.subheadline).fontWeight(.bold)
//            }
//            
//            LazyVGrid(columns: columns, spacing: 12) {
//                ForEach(timeSlots) { timeSlot in
//                    Button(action: {
//                        viewModel.selectTimeSlot(timeSlot: timeSlot)
//                    }) {
//                        TimeSlotView(
//                            timeSlot: timeSlot,
//                            isSelected: viewModel.selectedTimeSlotID == timeSlot.id
//                        )
//                    }
//                    .buttonStyle(.plain) // 버튼의 기본 스타일 제거
//                }
//            }
//        }
//        .padding(.top)
//    }
//}
//
//// 개별 시간표 버튼 하나를 그리는 뷰
//struct TimeSlotView: View {
//    let timeSlot: TimeframeModel
//    let isSelected: Bool // ✅ 6. 선택 상태를 받아오는 변수
//
//    var body: some View {
//        VStack(spacing: 4) {
//            Text(timeSlot.startTime)
//                .font(.headline)
//                .fontWeight(.bold)
//            
//            Text(timeSlot.endTime)
//                .font(.caption)
//                .foregroundStyle(isSelected ? .white.opacity(0.8) : .secondary)
//            
//            HStack(spacing: 0) {
//                Text("\(timeSlot.currentAudience)")
//                    // ✅ 7. 선택 상태에 따라 글자색 변경
//                    .foregroundStyle(isSelected ? .white : .purple)
//                Text(" / \(timeSlot.totalSeats)")
//                    .foregroundStyle(isSelected ? .white.opacity(0.8) : .secondary)
//            }
//            .font(.caption)
//            .fontWeight(.medium)
//        }
//        .padding(12)
//        .frame(maxWidth: .infinity)
//        // ✅ 8. 선택 상태에 따라 전체 글자색과 배경색 변경
//        .foregroundStyle(isSelected ? .white : .primary)
//        .background(isSelected ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color(UIColor.systemBackground))
//        .cornerRadius(12)
//        .overlay(
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(isSelected ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color.gray.opacity(0.3), lineWidth: 1.5)
//        )
//    }
//}
//
//// 지역 선택 버튼 스타일
//struct LocationButtonStyle: ButtonStyle {
//    let isSelected: Bool
//    
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding(.horizontal, 16)
//            .padding(.vertical, 8)
//            .background(isSelected ? Color.black : Color.clear)
//            .foregroundStyle(isSelected ? Color.white : Color.black)
//            .cornerRadius(16)
//            .overlay(
//                RoundedRectangle(cornerRadius: 16)
//                    .stroke(isSelected ? Color.clear : Color.gray.opacity(0.5), lineWidth: 1)
//            )
//    }
//}
//
//
//#Preview {
//    TimeframeView()
//}
