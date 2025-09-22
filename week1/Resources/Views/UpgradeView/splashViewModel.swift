//
//  splashViewModel.swift
//  Week1_Practice
//
//  Created by 육도연 on 9/27/25.

//splashViewModel.swift
import SwiftUI

class splashViewModel: ObservableObject {
    @AppStorage("ID") var ID: String = "ID"
    @AppStorage("password") var Password: String = "Password"
}
