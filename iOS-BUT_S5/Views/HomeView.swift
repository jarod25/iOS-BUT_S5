//
//  HomeView.swift
//  iOS-BUT_S5
//
//  Created by kohler jarod on 12/01/2024.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.637863, longitude: 6.858801), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))

        var body: some View {
            Map(coordinateRegion: $region, showsUserLocation: false, userTrackingMode: .constant(.follow))
        }
    

    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


