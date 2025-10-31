//
//  fiveMovieView.swift
//  Megabox_project
//
//  Created by 육도연 on 11/1/25.
//
//  UserListView.swift의 .task 패턴을 적용한 파일입니다.
//
import SwiftUI

struct FiveMovieView: View {
    // ViewModel 인스턴스 생성
    @StateObject private var viewModel = FiveMovieViewModel()
    @StateObject private var timePickerViewModel = FiveTimeframeViewModel()
    @StateObject private var datePickerViewModel = FiveDateSelectionViewModel()
    
    // 상태 변수
    @State private var selectedMovie: FiveMovieModel? = nil
    @State private var selectedDateUUID: UUID? = nil // 날짜 선택용 ID
    @State private var isShowingSheet = false
    
    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 80))]

    //상태 변화를 감지하고 변화를 주는 역활을 하고 있음
    //다른 struct를 그리고 나타내게하는 역활을 하고 있음
    var body: some View {
        NavigationStack {
            // 1. 모든 요소를 담을 단 하나의 메인 VStack
            VStack(spacing: 0) {
                // 상단 보라색 헤더 뷰를 그리는 역활
                FiveMovieHeaderView()
                
                // 영화/지역/날짜/시간 선택 UI
                FiveMovieSelectorView(
                    viewModel: viewModel,
                    timePickerViewModel: timePickerViewModel,
                    datePickerViewModel: datePickerViewModel,
                    selectedMovie: $selectedMovie,
                    selectedDateUUID: $selectedDateUUID,
                    isShowingSheet: $isShowingSheet,
                    columns: columns
                )
            }
            .ignoresSafeArea(.container, edges: .top)
            
            // [!] UserListView.swift처럼 .task를 사용해
            // [!] View가 나타날 때 비동기적으로 JSON 데이터를 로드합니다.
            
            .task { //작동을 하게 만듦
                await timePickerViewModel.loadScheduleData()
            }
            
            // 영화 검색 시트
            .sheet(isPresented: $isShowingSheet) {
                // [!] 이 뷰의 정의를 파일 하단에 다시 추가했습니다.
                FiveSearchView(
                    isPresented: $isShowingSheet,
                    selectedMovie: $selectedMovie
                )
            }
            
            // [!]
            // [!] .onChange는 ID(Key)가 변경될 때마다
            // [!] TimePickerViewModel에 알립니다.
            // [!]
    //===================중요====================
            //onChange를 이용해서 변화를 감지를 해서 눌리면 set에 저장을 하게 만듦
            .onChange(of: selectedMovie) { _, newMovie in
                // ViewModel에 영화 ID(String) 전달
                timePickerViewModel.selectedMovieID = newMovie?.id
            }
            .onChange(of: selectedDateUUID) { _, newDateUUID in
                // 날짜를 지정하고 보내는 역활
                // ViewModel에 날짜 String("2025-09-22") 전달
                // fivedayinfo.swift의 getDateString 함수를 호출
                timePickerViewModel.selectedDateString = datePickerViewModel.getDateString(from: newDateUUID)
            }
        }
    }
}

// MARK: - 1. 헤더 뷰
struct FiveMovieHeaderView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 0.4, green: 0.05, blue: 0.85)
            Text("영화별 예매")
                .font(.custom("Pretendard-Bold", size: 24))
                .foregroundStyle(Color.white)
                .padding()
        }
        .frame(height: 130)
    }
}

// MARK: - 2. 선택 영역 뷰
struct FiveMovieSelectorView: View {
    // ViewModels
    @ObservedObject var viewModel: FiveMovieViewModel
    @ObservedObject var timePickerViewModel: FiveTimeframeViewModel
    @ObservedObject var datePickerViewModel: FiveDateSelectionViewModel
    
    // Bindings
    @Binding var selectedMovie: FiveMovieModel?
    @Binding var selectedDateUUID: UUID?
    @Binding var isShowingSheet: Bool
    
    // Properties
    let columns: [GridItem]

    var body: some View {
        VStack(spacing: 0) {
            
            // --- 영화 목록 타이틀 바 ---
            HStack {
                HStack(spacing: 10) {
                    //약간은 selectedMovie?.age에서 가져온다고 개념
                    Text(selectedMovie?.age.description ?? "??")
                        .font(.custom("Pretendard-Bold", size: 14))
                        .foregroundStyle(.white)
                        .frame(width: 24, height: 24)
                        .background(Color.orange)
                        .cornerRadius(6)
                        .opacity(selectedMovie == nil ? 0 : 1)

                    Text(selectedMovie?.title ?? "영화를 선택하세요")
                        .font(.custom("Pretendard-Bold", size: 18))
                        // .foregroundStyle(selectedMovie == nil ? Color.secondary : Color.black) // 타입 추론 에러 방지
                        .foregroundStyle(selectedMovie == nil ? Color(UIColor.secondaryLabel) : Color(UIColor.label))
                }

                Spacer()

                // "전체영화" 버튼
                Button(action: { isShowingSheet = true }) {
                    Text("전체영화")
                        .font(.custom("Pretendard-SemiBold", size: 10))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .foregroundStyle(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)

            // --- 영화 포스터 스크롤 뷰 ---
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.movies) { movie in
                        Button(action: {
                            //다시 누르면 id가 맞는지 확인하는 if문 맞으면 nil 변형 아니면 id변경함
                            selectedMovie = (selectedMovie?.id == movie.id) ? nil : movie
                        }) {
                            Image(movie.movieImage)
                                .resizable().scaledToFit().frame(width: 62)
                                .cornerRadius(8)
                        }
                        .buttonStyle(FiveMoviePosterButtonStyle(isSelected: movie.id == selectedMovie?.id))
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 15)
            
            VStack(spacing: 10) {
                // --- 지역 선택 버튼 ---
                HStack(spacing: 5) {
                    // Location enum을 ForEach로 순회하며 버튼 생성
                    ForEach(Location.allCases, id: \.rawValue) { location in
                        Button(action: {
                //===========위치를 누르면 저장을 하게 하는 부분=======
                            timePickerViewModel.selectLocation(location)
                        }) {
                            Text(location.rawValue)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(timePickerViewModel.selectedLocations.contains(location) ? .white : .gray)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 15)
                                .background(timePickerViewModel.selectedLocations.contains(location) ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color(uiColor: .systemGray6))
                                .cornerRadius(12)
                        }
                    }
                    Spacer()
                }
                
                // --- 날짜 선택 뷰 ---
                // fivedayinfo.swift가 @Binding을 받도록 수정됨
                FiveDateSelectionView(
                    viewModel: datePickerViewModel,
                    //
                    selectedDateUUID: $selectedDateUUID
                    //
                )
                
                // --- 시간표 스크롤 뷰 ---
                // [!] 로직을 TimeSlotSelectionView로 분리
                TimeSlotSelectionView(
                    timePickerViewModel: timePickerViewModel,
                    columns: columns
                )
                
            }
            .padding(.horizontal, 20)
            
            Spacer() // 모든 콘텐츠를 위로 밀어 올림
        }
    }
}


// MARK: - 3. 시간표 선택 영역 (로직 분리)
struct TimeSlotSelectionView: View {
    @ObservedObject var timePickerViewModel: FiveTimeframeViewModel
    let columns: [GridItem]

    var body: some View {
        // [!] timePickerViewModel의 상태에 따라 분기 처리
        
        // 1. JSON 로딩 중
        if timePickerViewModel.isLoading {
            ProgressView("시간표 로딩 중...")
                .padding(.top, 40)
        
        // 2. JSON 로드 실패
        } else if let errorMessage = timePickerViewModel.errorMessage {
            VStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.red)
                    .font(.largeTitle)
                Text("오류 발생")
                    .font(.headline)
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 40)
            
        // 3. 조건 미선택
        } else if timePickerViewModel.selectedMovieID == nil {
            Text("영화를 먼저 선택해주세요.")
                .padding(.top, 40).foregroundStyle(.secondary)
        } else if timePickerViewModel.selectedDateString == nil {
            Text("날짜를 선택해주세요.")
                .padding(.top, 40).foregroundStyle(.secondary)
        } else if timePickerViewModel.selectedLocations.isEmpty {
            Text("영화관을 선택해주세요.")
                .padding(.top, 40).foregroundStyle(.secondary)
                
        // 4. 모든 조건 선택 + 데이터 없음
        } else if timePickerViewModel.displayableTheaters.isEmpty {
            Text("선택하신 조건의 상영 시간이 없습니다.")
                .padding(.top, 40).foregroundStyle(.secondary)
        
        // 5. [성공] 모든 조건 선택 + 데이터 있음===============
           // ========데이터를 끌고 이제 fivetimeframe에서 데이터를 가지고 스크롤이 생김
        } else {
            ScrollView(.vertical, showsIndicators: false) {//tm
                VStack(alignment: .leading, spacing: 10) {
                    // ViewModel이 DTO -> Domain으로 변환한 [Theater] 목록을 순회
                    ForEach(timePickerViewModel.displayableTheaters) { theater in
                        TheaterSectionView(
                            theater: theater,
                            viewModel: timePickerViewModel,
                            columns: columns
                        )
                    }
                }
            }
        }
    }
}


// MARK: - 4. 헬퍼 뷰 (TheaterSectionView, TimeSlotView 등)
// (fiveMovieView.swift 파일 하단에 이미 존재하던 뷰들)

// 눌렸을때 테두리에 색이 들어오는 함수
struct FiveMoviePosterButtonStyle: ButtonStyle {
    var isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected || configuration.isPressed ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color.clear, lineWidth: 3)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
            .animation(.easeOut(duration: 0.1), value: isSelected)
    }
}

// 영화관 섹션 (Theater Domain Model을 받도록 수정)
struct TheaterSectionView: View {
    let theater: Theater // DTO 대신 Domain Model 사용
    @ObservedObject var viewModel: FiveTimeframeViewModel
    let columns: [GridItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(theater.title).font(.headline).fontWeight(.bold)
                Spacer()
                Text(theater.format).font(.subheadline).fontWeight(.bold)
            }

            LazyVGrid(columns: columns, spacing: 12) {
                // Domain Model의 timeSlots 사용
                ForEach(theater.timeSlots) { timeSlot in
                    Button(action: {
                        viewModel.selectTimeSlot(timeSlot: timeSlot)
                    }) {
                        TimeSlotView(
                            timeSlot: timeSlot, // Domain Model 전달
                            isSelected: viewModel.selectedTimeSlotID == timeSlot.id
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.top)
    }
}

// 개별 시간표 (ShowtimeSlot Domain Model을 받도록 수정)
struct TimeSlotView: View {
    let timeSlot: ShowtimeSlot // DTO 대신 Domain Model 사용
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 4) {
            Text(timeSlot.startTime)
                .font(.headline)
                .fontWeight(.bold)

            Text(timeSlot.endTime)
                .font(.caption)
                .foregroundStyle(isSelected ? .white.opacity(0.8) : .secondary)

            HStack(spacing: 0) {
                // Domain Model의 available/total 사용
                Text("\(timeSlot.available)")
                    .foregroundStyle(isSelected ? .white : .purple)
                Text(" / \(timeSlot.total)")
                    .foregroundStyle(isSelected ? .white.opacity(0.8) : .secondary)
            }
            .font(.caption)
            .fontWeight(.medium)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .foregroundStyle(isSelected ? .white : .primary)
        .background(isSelected ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color(uiColor: .systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color.gray.opacity(0.3), lineWidth: 1.5)
        )
    }
}

//
// [!]
// [!] 여기가 핵심 수정 사항입니다!
// [!] "Cannot find 'FiveSearchView' in scope" 에러를 해결하기 위해
// [!] 누락되었던 FiveSearchView Struct를 다시 추가합니다.
// [!]
//
// MARK: - 5. 영화 검색 시트 (FiveSearchView)
struct FiveSearchView: View {
    @Binding var isPresented: Bool
    @Binding var selectedMovie: FiveMovieModel?
    
    // FiveMovieView가 이미 viewModel을 가지고 있으므로,
    // @StateObject 대신 @ObservedObject로 주입받는 것이 더 효율적일 수 있으나,
    // 기존 코드(fiveMovieView.swift 원본)의 @StateObject를 존중하여 그대로 사용합니다.
    @StateObject private var vm = FiveMovieViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 12) {
                Capsule()
                    .frame(width: 40, height: 5)
                    .foregroundColor(Color(.systemGray4))
                    .padding(.top, 8)
                
                Text("영화 선택")
                    .font(.custom("Pretendard-Bold", size: 20))
                    .foregroundStyle(.black)
                
                if vm.isLoading {
                    ProgressView("검색중…")
                }
                
                if let error = vm.errorMessage {
                    Text(error).foregroundStyle(.red)
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 40) {
                        // 검색 로직: vm.query가 비어있으면 vm.movies, 아니면 vm.results
                        ForEach(vm.query.isEmpty ? vm.movies : vm.results, id: \.id) { movie in
                            
                            VStack(spacing: 8) {
                                Button(action: {
                                    // 메인 뷰의 selectedMovie 변수를 지금 누른 영화로 업데이트
                                    selectedMovie = movie
                                    // 시트를 닫음
                                    isPresented = false
                                }){
                                    Image(movie.movieImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(8)
                                        .shadow(radius: 4)
                                }
                                .buttonStyle(FiveMoviePosterButtonStyle(isSelected: movie.id == selectedMovie?.id))
                                
                                Text(movie.title)
                                    .foregroundStyle(.black)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // 검색창
                HStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("영화명을 입력하세요", text: $vm.query)
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(.systemGray6))
                    .clipShape(Capsule())
                    
                    Button(action: {
                        vm.query = ""
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
            .padding(.horizontal, 20)
        }
    }
}


// MARK: - Preview
#Preview {
    FiveMovieView()
}

