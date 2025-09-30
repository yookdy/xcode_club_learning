//
//  LoginViewModel.swift
//  week2lean
//
//  Created by 육도연 on 9/27/25.
//LoginViewModel
import SwiftUI

class LoginViewModel: ObservableObject {
    @AppStorage("userID") var ID: String = "jwlee010540"
    @AppStorage("username") var username: String = "이재원"
}
