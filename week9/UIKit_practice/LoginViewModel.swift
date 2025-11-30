//
//  LoginViewModel.swift
//  9weeklean
//
//  Created by 육도연 on 11/30/25.
//
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @AppStorage("userID") var ID: String = "jwlee010540"
    @AppStorage("username") var username: String = "이재원"
}
