//
//  Usermodel.swift
//  week2lean
//
//  Created by 육도연 on 9/21/25.
//
//backend's concept, only calculate 벡엔드의 개념 계산만하는 역활
import Foundation

struct UserModel {
    var name: String
    var age: Int
    
    mutating func increaseAge() {
        self.age += 1
    }
    
    mutating func decreaseAge() {
        self.age -= 1
    }
}

