//
//  LoginView.swift
//  9weeklean
//
//  Created by 육도연 on 11/30/25.
//
import SwiftUI
import Combine

struct LoginView: View {
    @StateObject var user: LoginViewModel = .init()
    @State private var showImagePicker1 = false
    @State private var selectedImages: [UIImage] = []
    @State private var profileImage: UIImage? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack(alignment: .center, spacing: 15) {
                    Button(action: {
                        showImagePicker1 = true
                    }) {
                        if let image = profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 65, height: 65)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 65, height: 65)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 5) {
                            Text(user.username)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Image("welcome")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                        }
                        
                        Text("멤버쉽 포인트 500P")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    NavigationLink(destination: Userinfor().environmentObject(user)) {
                        Image("memberinfo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 80)
                
                Image("membership")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 10)
                
                Image("currinfo")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 10)
                
                HStack(alignment: .center, spacing: 30) {
                    Button(action: {}) { Image("Mvticket").resizable().scaledToFit() }
                    Button(action: {}) { Image("deposit").resizable().scaledToFit() }
                    Button(action: {}) { Image("specialreservation").resizable().scaledToFit() }
                    Button(action: {}) { Image("mobileti").resizable().scaledToFit() }
                }
                .frame(height: 80)
                .padding(.horizontal, 10)
                
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .sheet(isPresented: $showImagePicker1) {
                ImagePicker(images: $selectedImages, selectedLimit: 1)
            }
            .onChange(of: selectedImages) { oldValue, newImages in
                if let firstImage = newImages.first {
                    profileImage = firstImage
                    selectedImages = []
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
