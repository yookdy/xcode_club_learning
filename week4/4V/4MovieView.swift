////
////  4MovieView.swift
////  Megabox_project
////
////  Created by 육도연 on 10/11/25.
////
//
////MovieView.swift
//import SwiftUI
//
//struct FourMovieView: View {
//    @StateObject private var viewModel = FourMovieViewModel()//메인 데이터
//    @StateObject private var timePickerViewModel = TimeframeViewModel()//시간프레임데이터
//    @StateObject private var datePickerViewModel = DateSelectionViewModel()//날짜 데이터 가져옴
//    private let columns: [GridItem] = [GridItem(.adaptive(minimum: 80))]
//       
//    // 1. 현재 선택된 영화를 저장할 상태 변수 추가
//    @State private var selectedMovie: FourMovieModel? = nil
//    //각각의 영화관의 선택 유뮤
//    //날짜 선택
//    @State private var isShowingSheet = false
//    var body: some View {
//        NavigationStack {
//            // 1. 모든 요소를 담을 단 하나의 메인 VStack
//            VStack(spacing: 0) {
//                
//                // --- 보라색 헤더 ---
//                ZStack(alignment: .bottom) {
//                    Color(red: 0.4, green: 0.05, blue: 0.85)
//                    Text("영화별 예매")
//                        .font(.custom("Pretendard-Bold", size: 24))
//                        .foregroundStyle(Color.white)
//                        .padding()
//                }
//                .frame(height: 130)
////--------------------------------------------------------------------
//                // --- 영화 목록 타이틀 바 ---
//                VStack{
//                    HStack {
//                        HStack(spacing: 20) { // "15"와 "영화" 사이 간격 조절
//                            Text("15")
//                                .font(.custom("Pretendard-Bold", size: 14))
//                                .foregroundStyle(.white)
//                                .frame(width: 24, height: 24)
//                                .background(Color.orange)
//                                .cornerRadius(6)
//                            
//                            Text(selectedMovie?.title ?? "")
//                                .font(.custom("Pretendard-Bold", size: 18))
//                        }
//                        
//                        Spacer() // 버튼을 오른쪽 끝으로 밀어냄
//                        
//                        Button(action: {
//                            isShowingSheet = true
//                        }) {
//                            Text("전체영화")
//                                // 1. 폰트 크기를 12에서 10으로 줄였습니다.
//                                .font(.custom("Pretendard-SemiBold", size: 10))
//                                // 2. 텍스트와 외곽선 사이에 여백을 추가했습니다.
//                                .padding(.vertical, 4) // 위아래 여백
//                                .padding(.horizontal, 8) // 좌우 여백
//                                .foregroundStyle(Color.black)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 7)
//                                        .stroke(Color.gray, lineWidth: 1)
//                                )
//                                .sheet(isPresented: $isShowingSheet) {
//                                    // 미리 만들어 둔 MySheetView를 호출
//                                    // isShowingSheet 상태를 $ 표시와 함께 넘겨줌
//                                    SearchView(
//                                        isPresented: $isShowingSheet,
//                                        selectedMovie: $selectedMovie
//                                    )
//                                }
//                        }
//                    }
//                    .padding(.vertical, 10)   // 상하 여백 (헤더 및 포스터와의 간격)
//
//            // --------------영화 포스터 스크롤 뷰 ----------------------------
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 15) {
//                            ForEach(viewModel.movies) { movie in
//                                // 각 영화 포스터를 Button으로 감싸고 스타일 적용
//                                Button(action: {
//                                    if selectedMovie?.id == movie.id {
//                                        selectedMovie = nil
//                                        
//                                    } else {
//                                        // 그렇지 않다면, 새로 선택한 영화로 업데이트합니다.
//                                        selectedMovie = movie
//                                    }
//                                }) {
//                                    Image(movie.movieImage)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 62)
//                                        .cornerRadius(8)
//                                }
//                                // 💡 여기에 커스텀 ButtonStyle 적용
//                                .buttonStyle(MoviePosterButtonStyle(isSelected: movie.id == selectedMovie?.id))
//                            }
//                        }
//                    }//----------------------------------------------
//                    HStack(spacing: 5) {
//                        //강남
//                        Button(action: {
//                            timePickerViewModel.gtoggleGangnamSelection()
//                        }) {
//                            Text("강남")
//                                .font(.system(size: 16, weight: .bold))
//                                .foregroundStyle(timePickerViewModel.gselectedLocation == "강남" ? .white : .gray)
//                                .padding(.vertical, 5)
//                                .padding(.horizontal, 15)
//                                .background(timePickerViewModel.gselectedLocation == "강남" ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color(.systemGray6))
//                                .cornerRadius(12)
//                        }
//                        //홍대
//                        Button(action: {
//                            timePickerViewModel.htoggleGangnamSelection()
//                        }) {
//                            Text("홍대")
//                                .font(.system(size: 16, weight: .bold))
//                                .foregroundStyle(timePickerViewModel.hselectedLocation == "홍대" ? .white : .gray)
//                                .padding(.vertical, 5)
//                                .padding(.horizontal, 15)
//                                .background(timePickerViewModel.hselectedLocation == "홍대" ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color(.systemGray6))
//                                .cornerRadius(12)
//                        }
//                        Button(action: {
//                            timePickerViewModel.stoggleGangnamSelection()
//                        }) {
//                            Text("신촌")
//                                .font(.system(size: 16, weight: .bold))
//                                .foregroundStyle(timePickerViewModel.sselectedLocation == "신촌" ? .white : .gray)
//                                .padding(.vertical, 5)
//                                .padding(.horizontal, 15)
//                                .background(timePickerViewModel.sselectedLocation == "신촌" ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color(.systemGray6))
//                                .cornerRadius(12)
//                        }
//                        Spacer()
//                    }
//                    .padding(.top, 10)
//                    DateSelectionView(viewModel: datePickerViewModel)
//                        .padding(.top, 10) // 위쪽과 간격 추가
//                    // --- [추가된 부분] 영화, 날짜, 영화관이 모두 선택되었을 때 시간표 표시 ---
//                    ScrollView(.vertical, showsIndicators: false) {
//                        VStack(alignment: .leading, spacing: 10) {
//                            if selectedMovie != nil && datePickerViewModel.selectedDateId != nil {
//                                
//                                // 강남이 선택된 경우
//                                if timePickerViewModel.gselectedLocation != nil {
//                                    TheaterSectionView(
//                                        title: "크리클라이너 1관",
//                                        format: "2D",
//                                        timeSlots: timePickerViewModel.gtimeSlots,
//                                        columns: columns,
//                                        viewModel: timePickerViewModel
//                                    )
//                                }
//                                
//                                // 홍대가 선택된 경우
//                                if timePickerViewModel.hselectedLocation != nil {
//                                    TheaterSectionView(
//                                        title: "BTS관 (7층 1관 [Laser])",
//                                        format: "2D",
//                                        timeSlots: timePickerViewModel.htimeSlots,
//                                        columns: columns,
//                                        viewModel: timePickerViewModel
//                                    )
//                                    TheaterSectionView(
//                                        title: "BTS관 (9층 2관 [Laser])",
//                                        format: "2D",
//                                        timeSlots: timePickerViewModel.h2timeSlots, // 새로 추가한 데이터 사용
//                                        columns: columns,
//                                        viewModel: timePickerViewModel
//                                    )
//                                }
//                                
//                                // 신촌이 선택된 경우 (데이터가 없으므로 메시지 표시)
//                                if timePickerViewModel.sselectedLocation != nil {
//                                     Text("신촌점은 상영 정보가 없습니다.")
//                                         .padding()
//                                         .foregroundStyle(.secondary)
//                                }
//                            }
//                        }
//                    }
//                    //모든 콘텐츠를 위로 밀어 올리는 Spacer---------------------------------
//                    Spacer()
//                }
//                .padding(.horizontal, 20)
//                
//                
//            }
//            .ignoresSafeArea(.container, edges: .top)
//        }
//    }
//}
//
////---------------------------------검색 시트-------------------------------------------------------
//struct SearchView: View {
//    // 이 시트를 닫기 위해 ContentView의 isShowingSheet를 제어해야 함
//    // @Binding을 사용해 값을 공유
//    @Binding var isPresented: Bool//버튼의 눌림의 불리안 이용
//    @Binding var selectedMovie: FourMovieModel?
//    @StateObject private var vm = FourMovieViewModel()
//    let columns: [GridItem] = [
//        GridItem(.flexible(), spacing: 30),
//        GridItem(.flexible(), spacing: 30),
//        GridItem(.flexible(), spacing: 30)
//    ]
//    var body: some View {
//        NavigationStack {
//            VStack(alignment: .center, spacing: 12) {
//                Capsule()
//                    .frame(width: 40, height: 5)
//                    .foregroundColor(Color(.systemGray4))
//                    .padding(.top, 8)
//                Text("영화 선택")
//                    .font(.custom("Pretendard-Bold", size: 20))
//                    .foregroundStyle(.black)
//                if vm.isLoading {
//                    ProgressView("검색중…")
//                }//로딩처리
//
//                if let error = vm.errorMessage {
//                    Text(error).foregroundStyle(.red)
//                }//에러처리 상황
//                
//                //나오는 결과값을 리스트 형식을 이용해서 나열함-----------------------
//                ScrollView {
//                    // 3. LazyVGrid를 사용해 그리드 레이아웃을 만듭니다.
//                    LazyVGrid(columns: columns, spacing: 40) {
//                        // vm.movies 또는 vm.results를 사용해 영화 데이터를 반복 표시합니다.
//                        // 검색 기능과 연동하려면 vm.results, 초기 화면은 vm.movies
//                        ForEach(vm.query.isEmpty ? vm.movies : vm.results, id: \.id) { movie in //isEmpty를 이용해서 내용물이 있는지에 따른 조건문을 이용함
//                            
//                            // 4. 각 영화 아이템의 UI (이미지와 텍스트를 세로로 배치)
//                            VStack(spacing: 8) {
//                                Button(action: {
//                                    //메인 뷰의 selectedMovie 변수를 지금 누른 영화로 업데이트
//                                    selectedMovie = movie
//                                    //시트를 닫음
//                                    isPresented = false
//                                }){
//                                    Image(movie.movieImage)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .cornerRadius(8) // 이미지 모서리를 살짝 둥글게
//                                        .shadow(radius: 4) // 그림자 효과 추가
//                                }
//                                .buttonStyle(MoviePosterButtonStyle(isSelected: movie.id == selectedMovie?.id))
//                                Text(movie.title)
//                                    .foregroundStyle(.black)
//                                    .font(.caption)
//                                    .fontWeight(.medium)
//                                    .lineLimit(1) // 제목이 길 경우 한 줄로 제한
//                            }
//                        }
//                    }
//                    .padding(.horizontal) // 그리드 전체의 좌우 여백
//                }//---------------------------------------------------
//                Spacer()
//
//                //맨 아래에 위치할 검색창----------------------------------
//                HStack(spacing: 12) {
//                    // 1. 검색창 (기존 코드와 거의 동일)
//                    HStack(spacing: 12) {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.gray)
//                        TextField("영화명을 입력하세요", text: $vm.query)
//                        Image(systemName: "mic.fill")
//                            .foregroundColor(.gray)
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 12)
//                    .background(Color(.systemGray6))
//                    .clipShape(Capsule())
//
//                    // 2. ✨ X 버튼 (이 부분을 수정)
//                    Button(action: {
//                        vm.query = ""
//                    }) {
//                        Image(systemName: "xmark")
//                            .foregroundColor(.gray)
//                            .padding(8) // 아이콘 주변에 여백을 줘서 원을 만듦
//                            .background(Color(.systemGray6))
//                            .clipShape(Circle()) // 모양을 원으로 자름
//                    }
//                }
//                // 전체 뷰의 좌우, 하단 여백을 설정
//                .padding(.horizontal)
//                .padding(.bottom, 8)
//                //----------------------------------------------------
//            }
//            .padding(.horizontal, 20)
//        }
//    
//    }
//}
// 
////눌렸을때 테두리에 색이 들어오는 함수----------------------------------------
//struct MoviePosterButtonStyle: ButtonStyle {
//    // 5. 현재 버튼이 선택된 상태인지 전달받는 프로퍼티
//    var isSelected: Bool//눌린 상태에 따라 불리안으로 변경
//
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .overlay(
//                //6. 선택되었거나(isSelected), 눌렸을 때(isPressed) 테두리 표시
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(isSelected || configuration.isPressed ? Color(red: 0.4, green: 0.05, blue: 0.85) : Color.clear, lineWidth: 3)
//            )
//            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
//            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
//            .animation(.easeOut(duration: 0.1), value: isSelected) // 선택 상태 변경에도 애니메이션 적용
//    }
//}
//
//#Preview {
//    FourMovieView()
//}
//
