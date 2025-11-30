//
//  ContentView.swift
//  9weeklean
//
//  Created by 육도연 on 11/27/25.
//

import MapKit
import SwiftUI

struct ConteView: View {
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    var body: some View {
        Map(position: $position) {
            Marker("스타벅스 강남점", coordinate: CLLocationCoordinate2D(
                latitude: 37.4979,
                longitude: 127.0276
            ))
            .tint(.green)

            Annotation("이디야 서울대입구점",
                       coordinate: CLLocationCoordinate2D(latitude: 37.4814, longitude: 126.9526)) {
                ZStack {
                    Circle()
                        .fill(.blue.opacity(0.3))
                        .frame(width: 40)
                    Image(systemName: "cup.and.saucer.fill")
                        .foregroundStyle(.blue)
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }
}


#Preview {
    ConteView()
}

