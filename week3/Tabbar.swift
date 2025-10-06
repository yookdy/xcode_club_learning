//
//  Tabbar.swift
//  3weeklean
//
//  Created by 육도연 on 10/9/25.
//

import SwiftUI

struct Tabbar: View {
    var body: some View {
        TabView {
            Tab("Received", systemImage: "tray.and.arrow.down.fill") {
               MovieMainView()
            }
            .badge(2)


            Tab("Sent", systemImage: "tray.and.arrow.up.fill") {
                
            }


            Tab("Account", systemImage: "person.crop.circle.fill") {
                
            }
            .badge("!")
        }
    }
}
#Preview {
    Tabbar()
}
