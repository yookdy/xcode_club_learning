//
//  UserViewModel.swift
//  week2lean
//
//  Created by 육도연 on 9/21/25.
//
//the role of a messenger 전달자 역활
import Foundation

class UserViewModel: ObservableObject {
    
    @Published var userModel: UserModel
    
    init(userModel: UserModel) {
        self.userModel = userModel
    }
    
    func increaseAge() {
        self.userModel.increaseAge()
    }
    
    func decreaseAge() {
        self.userModel.decreaseAge()
    }
    
}
