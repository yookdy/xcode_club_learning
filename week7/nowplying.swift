//
//  nowplying.swift
//  3weeklean
//
//  Created by 육도연 on 11/17/25.


// import Foundation
//
// let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
// var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
// let queryItems: [URLQueryItem] = [
//   URLQueryItem(name: "language", value: "en-US"),
//   URLQueryItem(name: "page", value: "1"),
// ]
// components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
//
// var request = URLRequest(url: components.url!)
// request.httpMethod = "GET"
// request.timeoutInterval = 10
// request.allHTTPHeaderFields = ["accept": "application/json"]
//
// let (data, _) = try await URLSession.shared.data(for: request)
// print(String(decoding: data, as: UTF8.self))
//
